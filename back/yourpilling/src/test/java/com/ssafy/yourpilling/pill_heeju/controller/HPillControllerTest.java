package com.ssafy.yourpilling.pill_heeju.controller;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.PillProductForm;
import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.pill.model.dao.entity.OwnPill;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.jpa.OwnPillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillJpaRepository;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillMemberJpaRepository;
import com.ssafy.yourpilling.pill_heeju.model.dao.jpa.HPillMemberJpaRepository;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.security.auth.jwt.JwtManager;
import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.dao.jpa.MemberRepository;
import net.minidev.json.JSONObject;
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
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

import static java.time.LocalDate.now;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
@ActiveProfiles("dev")
class HPillControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private PillJpaRepository pillJpaRepository;

    @Autowired
    private OwnPillJpaRepository ownPillJpaRepository;

    @Autowired
    private JwtManager jwtManager;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private PillMemberJpaRepository pillMemberJpaRepository;

    @Test
    @DisplayName("영양제 검색 후 상세 조회")
    public void test() throws Exception {
        // given
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);
        Pill pill = defaultRegisterPill();

        registerOwnPill(true, member.getMemberId(), pill);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .get("/api/v1/pill/detail?pillId=" + pill.getPillId())
                .header("accessToken", accessToken)
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk())
                .andExpect(jsonPath("$.alreadyHave").value(true));
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
                .username("sdfsdgsdmgk")
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