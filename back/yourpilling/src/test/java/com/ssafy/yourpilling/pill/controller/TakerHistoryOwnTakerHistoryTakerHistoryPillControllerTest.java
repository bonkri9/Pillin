package com.ssafy.yourpilling.pill.controller;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.PillProductForm;
import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.entity.PillMember;
import com.ssafy.yourpilling.pill.model.dao.jpa.OwnPillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillMemberJpaRepository;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.security.auth.entity.Member;
import com.ssafy.yourpilling.security.auth.jwt.JwtManager;
import com.ssafy.yourpilling.security.auth.repository.MemberRepository;

import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

import static java.time.LocalDate.now;
import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
@DisplayName("영양제 통합 테스트")
class TakerHistoryOwnTakerHistoryTakerHistoryPillControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private JwtManager jwtManager;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private PillJpaRepository pillJpaRepository;

    @Autowired
    private OwnPillJpaRepository ownPillJpaRepository;

    @Autowired
    private PillMemberJpaRepository pillMemberJpaRepository;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Test
    @DisplayName("보유중인 영양제 정보 상세 조회")
    public void detail() throws Exception {
        // given
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);
        Pill pill = defaultRegisterPill();

        OwnPill ownPill = registerOwnPill(true, member.getMemberId(), pill);
        JSONObject body = new JSONObject();
        body.put("ownPillId", ownPill.getOwnPillId());

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .get("/api/v1/pill/inventory")
                .header("accessToken", accessToken)
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());

        JSONObject result = new JSONObject(perform.andReturn().getResponse().getContentAsString());
        assertEquals(ownPill.getOwnPillId(), result.getInt("ownPillId"));
        assertEquals(ownPill.getRemains(), result.getInt("remains"));
        assertEquals(ownPill.getTotalCount(), result.getInt("totalCount"));
        assertEquals(ownPill.getTakeCount(), result.getInt("takeCount"));
        assertEquals(ownPill.getTakeOnceAmount(), result.getInt("takeOnceAmount"));
        assertEquals(ownPill.getStartAt().toString(), result.getString("startAt"));
        assertEquals("danger", result.getString("warningMessage"));
    }

    @Test
    @DisplayName("보유중인 영양제 등록")
    public void register() throws Exception {
        // given
        Member member = defaultRegisterMember();
        Pill pill = defaultRegisterPill();

        String accessToken = getAccessToken(member);

        JSONArray takeWeekdays = new JSONArray();
        takeWeekdays.put("mOn");
        takeWeekdays.put("tue");
        takeWeekdays.put("Wed");
        takeWeekdays.put("thu");
        takeWeekdays.put("frI");
        takeWeekdays.put("SAt");
        takeWeekdays.put("SUN");

        JSONObject body = new JSONObject();
        body.put("pillId", pill.getPillId());
        body.put("startAt", now());
        body.put("takeYn", true);
        body.put("remains", 60);
        body.put("totalCount", 60);
        body.put("takeWeekdays", takeWeekdays); // 매일
        body.put("takeCount", 1); // 1회당
        body.put("takeOnceAmount", 1); // 1정

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .post("/api/v1/pill/inventory")
                .header("accessToken", accessToken)
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());
        assertFalse(pillJpaRepository.findByName(pill.getName()).isEmpty());
    }

    @Test
    @DisplayName("보유중인 영양제 정보 수정. 재고 관리 Ok")
    public void updateAndMaintainOk() throws Exception {
        // given
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);
        Pill pill = defaultRegisterPill();

        OwnPill ownPill = registerOwnPill(true, member.getMemberId(), pill);

        JSONArray takeWeekdays = new JSONArray();
        takeWeekdays.put("Wed");
        takeWeekdays.put("SAt");

        JSONObject body = new JSONObject();
        body.put("ownPillId", ownPill.getOwnPillId());
        body.put("remains", 3);
        body.put("totalCount", 30);
        body.put("takeWeekdays", takeWeekdays);
        body.put("takeCount", 2);
        body.put("takeOnceAmount", 2);
        body.put("takeYn", true);
        body.put("startAt", LocalDate.now());

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .put("/api/v1/pill/inventory")
                .header("accessToken", accessToken)
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());
        OwnPill saved = ownPillJpaRepository.findByOwnPillId(ownPill.getOwnPillId()).get();

        assertEquals(body.getInt("remains"), saved.getRemains());
        assertEquals(body.getInt("totalCount"), saved.getTotalCount());
        assertEquals(((1<<2) ^ (1<<5)), saved.getTakeWeekdays()); // 수, 토
        assertEquals(body.getInt("takeCount"), saved.getTakeCount());
        assertEquals(body.getInt("takeOnceAmount"), saved.getTakeOnceAmount());
        assertEquals(body.getBoolean("takeYn"), saved.getTakeYN());
        assertEquals(body.getString("startAt"), saved.getStartAt().toString());
    }

    @Test
    @DisplayName("보유중인 영양제 정보 수정. 재고 관리 No")
    public void updateAndMaintainNo() throws Exception {
        // given
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);
        Pill pill = defaultRegisterPill();

        OwnPill ownPill = registerOwnPill(true, member.getMemberId(), pill);

        JSONObject body = new JSONObject();
        body.put("ownPillId", ownPill.getOwnPillId());
        body.put("takeYn", false);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .put("/api/v1/pill/inventory")
                .header("accessToken", accessToken)
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());
        OwnPill saved = ownPillJpaRepository.findByOwnPillId(ownPill.getOwnPillId()).get();

        assertNull(saved.getRemains());
        assertNull(saved.getTotalCount());
        assertNull(saved.getTakeWeekdays());
        assertNull(saved.getTakeCount());
        assertNull(saved.getTakeOnceAmount());
        assertNull(saved.getStartAt());

        assertFalse(saved.getTakeYN());
    }

    @Test
    @DisplayName("보유중인 영양제 조회")
    public void list() throws Exception {
        // given
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);
        Pill pill = defaultRegisterPill();

        OwnPill one = registerOwnPill(true, member.getMemberId(), pill);
        OwnPill two = registerOwnPill(true, member.getMemberId(), pill);
        OwnPill three = registerOwnPill(false, member.getMemberId(), pill);

        PillMember pillMember = pillMemberJpaRepository.findByMemberId(member.getMemberId()).get();
        pillMember.getOwnPills().add(one);
        pillMember.getOwnPills().add(two);
        pillMember.getOwnPills().add(three);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .get("/api/v1/pill/inventory/list")
                .header("accessToken", accessToken)
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());
        String value = perform.andReturn().getResponse().getContentAsString();

        JSONObject response = new JSONObject(value);
        JSONObject takeTrue = response.getJSONObject("takeTrue");
        JSONArray takeTrueData = takeTrue.getJSONArray("data");
        assertEquals(2, takeTrueData.length());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        assertEquals(10, ChronoUnit.DAYS.between(now(),
                LocalDate.parse(takeTrueData.getJSONObject(0).getString("predicateRunOutAt"), formatter))); // 10일 차이
        assertEquals(10, ChronoUnit.DAYS.between(now(),
                LocalDate.parse(takeTrueData.getJSONObject(1).getString("predicateRunOutAt"), formatter)));
        assertEquals(takeTrueData.getJSONObject(0).getLong("ownPillId"), one.getOwnPillId());
        assertEquals(takeTrueData.getJSONObject(1).getLong("ownPillId"), two.getOwnPillId());

        JSONObject takeFalse = response.getJSONObject("takeFalse");
        JSONArray takeFalseData = takeFalse.getJSONArray("data");
        assertEquals(1, takeFalseData.length());

        assertEquals("null", takeFalseData.getJSONObject(0).getString("predicateRunOutAt"));
        assertEquals(takeFalseData.getJSONObject(0).getLong("ownPillId"), three.getOwnPillId());
    }

    @Test
    public void remove() throws Exception {
        // given
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);
        Pill pill = defaultRegisterPill();
        Pill pill2 = defaultRegisterPill();
        Pill pill3 = defaultRegisterPill();

        OwnPill one = registerOwnPill(true, member.getMemberId(), pill);
        OwnPill two = registerOwnPill(true, member.getMemberId(), pill2);
        OwnPill three = registerOwnPill(false, member.getMemberId(), pill3);

        JSONObject body = new JSONObject();
        body.put("ownPillId", one.getOwnPillId());

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .delete("/api/v1/pill/inventory")
                .header("accessToken", accessToken)
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());
        assertTrue(ownPillJpaRepository.findByOwnPillId(one.getOwnPillId()).isEmpty());
        assertFalse(ownPillJpaRepository.findByOwnPillId(two.getOwnPillId()).isEmpty());
        assertFalse(ownPillJpaRepository.findByOwnPillId(three.getOwnPillId()).isEmpty());
    }

    private OwnPill registerOwnPill(boolean takeYN, Long memberId, Pill pill){
        OwnPill ownPill = OwnPill
                .builder()
                .remains(10)
                .totalCount(60)
                .takeCount(1)
                .takeWeekdays((1<<7)-1) // 월~일
                .takeOnceAmount(1)
                .isAlarm(false)
                .takeYN(takeYN)
                .startAt(now())
                .createdAt(LocalDateTime.now())
                .member(pillMemberJpaRepository.findByMemberId(memberId).get())
                .pill(pill)
                .build();

        ownPillJpaRepository.save(ownPill);
        return ownPill;
    }

    private Pill defaultRegisterPill(){
        Pill pill = Pill
                .builder()
                .name("name")
                .manufacturer("manufacturer")
                .expirationAt(now())
                .usageInstructions("usageInstructions")
                .primaryFunctionality("primaryFunctionality")
                .precautions("precautions")
                .storageInstructions("storageInstructions")
                .standardSpecification("standardSpecification")
                .productForm(PillProductForm.TABLET)
                .imageUrl("imageUrl")
                .takeCount(1)
                .takeCycle(1)
                .createdAt(LocalDateTime.now())
                .build();


        pillJpaRepository.save(pill);

        return pill;
    }

    private Member defaultRegisterMember(){
        Member member = Member
                .builder()
                .username("q123123")
                .password(encoder.encode("1234"))
                .name("ksb")
                .nickname("k")
                .birth(now())
                .gender(Gender.MAN)
                .createdAt(LocalDateTime.now())
                .role(Role.MEMBER)
                .build();

        if(memberRepository.findByUsername(member.getUsername()).isEmpty()){
            memberRepository.save(member);
        }
        return member;
    }

    private String getAccessToken(Member member){
        String accessToken = jwtManager.createAccessToken(new PrincipalDetails(member));

        if (accessToken != null && jwtManager.isTokenValid(accessToken)) {
            Authentication authentication = jwtManager.getAuthentication(accessToken);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            return accessToken;
        }
        throw new IllegalArgumentException("테스트 토큰 생성 실패!");
    }
}