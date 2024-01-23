package com.ssafy.yourpilling.member.controller;

import com.ssafy.yourpilling.member.model.dao.entity.MemberProfile;
import com.ssafy.yourpilling.member.model.dao.jpa.MemberJpaRepository;
import net.minidev.json.JSONObject;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@Transactional
@AutoConfigureMockMvc
@DisplayName("member 통합 테스트")
class MemberControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private MemberJpaRepository memberJpaRepository;

    @Autowired
    private BCryptPasswordEncoder encoder;

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
}