package com.ssafy.yourpilling.pill.controller;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.PillProductForm;
import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.pill.model.dao.entity.Pill;
import com.ssafy.yourpilling.pill.model.dao.jpa.PillJpaRepository;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.security.auth.entity.Member;
import com.ssafy.yourpilling.security.auth.jwt.JwtManager;
import com.ssafy.yourpilling.security.auth.repository.MemberRepository;
import jakarta.persistence.EntityManager;
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
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
@DisplayName("영양제 통합 테스트")
class PillControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private JwtManager jwtManager;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private PillJpaRepository pillJpaRepository;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private EntityManager em;

    @Test
    @DisplayName("보유중인 영양제 등록")
    public void register() throws Exception {
//        // given
//        Member member = defaultRegisterMember();
//        Pill pill = defaultRegisterPill();
//
//
//        List<Member> all = memberRepository.findAll();
//        List<Pill> all1 = pillJpaRepository.findAll();
//
//        String accessToken = getAccessToken(member);
//
//        JSONObject body = new JSONObject();
//        //body.put("pillId", pill.getPillId());
//        body.put("startAt", LocalDate.now());
//        body.put("takeYn", true);
//        body.put("remains", 60);
//        body.put("totalCount", 60);
//        body.put("takeCount", 1);
//
//        Optional<Member> byId = memberRepository.findByMemberId(memberRepository.findByUsername(member.getUsername()).get().getMemberId());
//        Member member1 = byId.get();
//
//        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
//                .post("/api/v1/pill/inventory")
//                .header("accessToken", accessToken)
//                .content(body.toString())
//                .contentType(MediaType.APPLICATION_JSON);
//
//        // when, then
//        mockMvc.perform(request)
//                .andExpect(status().isOk());
    }

    private Pill defaultRegisterPill(){
        Pill pill = Pill
                .builder()
                .name("name")
                .manufacturer("manufacturer")
                .expirationAt(LocalDate.now())
                .usageInstructions("usageInstructions")
                .primaryFunctionality("primaryFunctionality")
                .precautions("precautions")
                .storageInstructions("storageInstructions")
                .standardSpecification("standardSpecification")
                .productForm(PillProductForm.TABLET)
                .imageUrl("imageUrl")
                .takeCount(0.5)
                .createdAt(LocalDateTime.now())
                .build();

        if(pillJpaRepository.findByName(pill.getName()).isEmpty()){
            pillJpaRepository.save(pill);
            em.persist(pill);
        }
        return pill;
    }

    private Member defaultRegisterMember(){
        Member member = Member
                .builder()
                .username("q123123")
                .password(encoder.encode("1234"))
                .name("ksb")
                .nickname("k")
                .birth(LocalDate.now())
                .gender(Gender.MAN)
                .createdAt(LocalDateTime.now())
                .role(Role.MEMBER)
                .build();

        if(memberRepository.findByUsername(member.getUsername()).isEmpty()){
            memberRepository.save(member);
            em.persist(member);
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