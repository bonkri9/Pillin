package com.ssafy.yourpilling.rank.controller;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.security.auth.jwt.JwtManager;
import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.dao.jpa.MemberRepository;
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
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
@ActiveProfiles("dev")
@DisplayName("랭크 테스트")
class RankControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private JwtManager jwtManager;

    @Test
    @DisplayName("모든 키테고리")
    public void allCategories() throws Exception {
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);


        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .get("/api/v1/rank/categories")
                .header("accessToken", accessToken)
                .contentType(MediaType.APPLICATION_JSON);

        ResultActions perform = mockMvc.perform(request);

        perform.andExpect(status().isOk());

        System.out.println(perform.andReturn().getResponse().getContentAsString());
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
}