package com.ssafy.yourpilling.pill_joohyuk.controller;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.security.auth.jwt.JwtManager;
import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.dao.jpa.MemberRepository;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryOwnPill;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryPill;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryPillMember;
import com.ssafy.yourpilling.takerhistory.model.dao.entity.TakerHistoryTakerHistory;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryOwnPillRepository;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryPillMemberRepository;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryPillRepository;
import com.ssafy.yourpilling.takerhistory.model.dao.jpa.TakerHistoryTakerHistoryRepository;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;

import java.time.LocalDate;
import java.time.LocalDateTime;

import static java.time.LocalDate.now;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
@ActiveProfiles("dev")
@DisplayName("일일 복용 기록 통합 테스트")
class HistoryControllerTest {

    // 통합 테스트 코드 작성
    // 크게 두가지가 있음
    // @SpringBootTest : 통합테스트 작성할때 주로 씀 - 모든 Bean 등록
    // @Transactional : 롤백 때문에 붙임 -> 테스트가 DB에 반영되면 안되니까!
    // @AutoConfigureMockMvc : 컨트롤러에 요청을 보내기 위해 - 포스트맨 역할


    @Autowired
    private MockMvc mockMvc; // 컨트롤러에 요청 보내는 객체

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private TakerHistoryPillRepository pillJpaRepository;

    @Autowired
    private TakerHistoryOwnPillRepository ownPillJpaRepository;

    @Autowired
    private TakerHistoryPillMemberRepository pillMemberJpaRepository;

    @Autowired
    private TakerHistoryTakerHistoryRepository historyJpaRepository;

    @Autowired
    private JwtManager jwtManager;

    @Autowired
    private WebApplicationContext ctx;

    @BeforeEach
    public void setup() {
        mockMvc = MockMvcBuilders.webAppContextSetup(ctx)
                .addFilter(new CharacterEncodingFilter("UTF-8", true))
                .build();
    }

    @Test
    @DisplayName("일일 복용 기록 상세 조회 테스트")
    public void detail() throws Exception {

        // 테스트는 public이고 void고 파라미터가 없어야한다.

        // 기본적으로 테스트는 given when then
        // given : 이게 주어졌을때
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);
        TakerHistoryPillMember pillMember = pillMemberJpaRepository.findByMemberId(member.getMemberId()).get();

        TakerHistoryPill pill1 = defaultRegisterPill("비타민A");
        TakerHistoryPill pill2 = defaultRegisterPill("비타민B");
        TakerHistoryPill pill3 = defaultRegisterPill("비타민C");

        TakerHistoryOwnPill one = registerOwnPill(true, member.getMemberId(), pill1);
        TakerHistoryOwnPill two = registerOwnPill(true, member.getMemberId(), pill2);
        TakerHistoryOwnPill three = registerOwnPill(false, member.getMemberId(), pill3);

        TakerHistoryTakerHistory history1 = defaultRegisterTakerHistory(one);
        TakerHistoryTakerHistory history2 = defaultRegisterTakerHistory(two);
        TakerHistoryTakerHistory history3 = defaultRegisterTakerHistory(three);

        int year = LocalDate.now().getYear();
        int month = LocalDate.now().getMonth().getValue();
        int day = LocalDate.now().getDayOfMonth();

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .get(String.format("/api/v1/pill/history/daily?year=%d&month=%d&day=%d", year, month, day))
                .header("accessToken", accessToken)
                .contentType(MediaType.APPLICATION_JSON);

        // when : 동작이 되고
        ResultActions perform = mockMvc.perform(request);

        // then : 결과가 어떤가
        perform.andExpect(status().isOk());

        JSONObject responseJSON = new JSONObject(perform.andReturn().getResponse().getContentAsString());

        JSONArray taken = responseJSON.getJSONArray("taken");

        String[] ans = {"비타민A", "비타민B", "비타민C"};
        for (int idx = 0; idx < taken.length(); idx++) {
            System.out.println(idx + "th index : " + taken.get(idx) + " ");
        }

        Assertions.assertEquals(ans[0], taken.getJSONObject(0).getString("name"));
        Assertions.assertEquals(ans[1], taken.getJSONObject(1).getString("name"));
        Assertions.assertEquals(ans[2], taken.getJSONObject(2).getString("name"));

    }

    private TakerHistoryTakerHistory defaultRegisterTakerHistory(TakerHistoryOwnPill ownPill) {

        LocalDate now = LocalDate.now();

        TakerHistoryTakerHistory takerHistory = TakerHistoryTakerHistory
                .builder()
                .needToTakeCount(1)
                .currentTakeCount(1)
                .takeAt(now)
                .createdAt(LocalDateTime.now())
                .ownPill(ownPill)
                .build();

        if (historyJpaRepository.findByTakeAtAndOwnPillOwnPillId(now, ownPill.getOwnPillId()).isEmpty()) {
            historyJpaRepository.save(takerHistory);
        }

        return takerHistory;
    }


    private Member defaultRegisterMember() {
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

        if (memberRepository.findByUsername(member.getUsername()).isEmpty()) {
            memberRepository.save(member);
        }
        return member;
    }

    private String getAccessToken(Member member) {
        String accessToken = jwtManager.createAccessToken(new PrincipalDetails(member));

        if (accessToken != null && jwtManager.isTokenValid(accessToken)) {
            Authentication authentication = jwtManager.getAuthentication(accessToken);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            return accessToken;
        }
        throw new IllegalArgumentException("테스트 토큰 생성 실패!");
    }


    private TakerHistoryOwnPill registerOwnPill(boolean takeYN, Long memberId, TakerHistoryPill pill) {
        TakerHistoryOwnPill ownPill = TakerHistoryOwnPill
                .builder()
                .takeCount(1)
                .takeOnceAmount(1)
                .member(pillMemberJpaRepository.findByMemberId(memberId).get())
                .pill(pill)
                .build();

        ownPillJpaRepository.save(ownPill);
        return ownPill;
    }

    private TakerHistoryPill defaultRegisterPill(String name) {
        TakerHistoryPill pill = TakerHistoryPill
                .builder()
                .name(name)
                .build();

        if (pillJpaRepository.findByName(pill.getName()).isEmpty()) {
            pillJpaRepository.save(pill);
        }
        return pill;
    }
}