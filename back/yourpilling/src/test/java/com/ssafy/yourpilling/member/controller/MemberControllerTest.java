package com.ssafy.yourpilling.member.controller;

import com.ssafy.yourpilling.common.Gender;
import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.dao.jpa.MemberJpaRepository;
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

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

import static java.time.LocalDate.now;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
@ActiveProfiles("dev")
@DisplayName("member 통합 테스트")
class MemberControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private MemberJpaRepository memberJpaRepository;

    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private JwtManager jwtManager;

    @Test
    @DisplayName("회원가입")
    public void register() throws Exception {
        // given
        String email = "testregister@gmail.com";

        JSONObject body = new JSONObject();
        body.put("email", email);
        body.put("password", "a1234567");
        body.put("birthday", LocalDate.now().toString());
        body.put("nickname", "nick");
        body.put("name", "n");
        body.put("gender", "man");

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .post("/api/v1/register")
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        // when, then
        mockMvc.perform(request)
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("중복된 이메일로 회원가입 시도")
    public void duplicatedEmail() throws Exception {
        // given
        String email = "testdup12@test.com";

        if (memberJpaRepository.findByUsername(email).isEmpty()) {
            memberJpaRepository.save(MemberProfile.builder()
                    .username(email)
                    .password(encoder.encode("1234"))
                            .role(Role.MEMBER)
                    .build()
            );
        }

        JSONObject body = new JSONObject();
        body.put("email", email);
        body.put("password", "a1234567");

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .post("/api/v1/register")
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);


        // when, then
        mockMvc.perform(request)
                .andExpect(status().is5xxServerError())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$.stateCode").value(500))
                .andExpect(jsonPath("$.errorCode").value("5001"))
                .andExpect(jsonPath("$.message").value("서버에러"));
    }

    @Test
    @DisplayName("회원 정보 조회")
    public void info() throws Exception {
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .get("/api/v1/member")
                .header("accessToken", accessToken)
                .contentType(MediaType.APPLICATION_JSON);

        // when, then
        mockMvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.email").value(member.getUsername()))
                .andExpect(jsonPath("$.name").value(member.getName()))
                .andExpect(jsonPath("$.gender").value(member.getGender().getGender()))
                .andExpect(jsonPath("$.nickname").value(member.getNickname()))
                .andExpect(jsonPath("$.birthday").value(member.getBirth().toString()));

    }

    @Test
    @DisplayName("회원 닉네임 정보 수정")
    public void update() throws Exception {
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);

        String change = "change";

        JSONObject body = new JSONObject();
        body.put("nickname", change);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .put("/api/v1/member")
                .header("accessToken", accessToken)
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());
        assertEquals(memberJpaRepository.findByMemberId(member.getMemberId()).get().getNickname(), change);
    }

    @Test
    @DisplayName("회원 탈퇴")
    public void delete() throws Exception {
        // when
        Member member = defaultRegisterMember();
        String accessToken = getAccessToken(member);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .delete("/api/v1/member")
                .header("accessToken", accessToken)
                .contentType(MediaType.APPLICATION_JSON);

        // when
        ResultActions perform = mockMvc.perform(request);

        // then
        perform.andExpect(status().isOk());
        assertTrue(memberJpaRepository.findByUsername(member.getUsername()).isEmpty());
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