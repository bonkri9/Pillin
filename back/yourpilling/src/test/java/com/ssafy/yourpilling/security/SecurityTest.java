package com.ssafy.yourpilling.security;

import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.jwt.JwtProperties;
import com.ssafy.yourpilling.security.auth.model.dao.jpa.MemberRepository;
import org.json.JSONObject;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.transaction.annotation.Transactional;

import static java.time.LocalDate.now;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("dev")
@Transactional
@DisplayName("시큐리티 로그인 테스트")
public class SecurityTest {

    @Autowired
    private MockMvc mockMvc;


    @Autowired
    private BCryptPasswordEncoder encoder;

    @Autowired
    private MemberRepository memberRepository;

    @Test
    @DisplayName("로그인")
    public void login() throws Exception {
        // given
        String username = "teststst@qweqwe.com";
        String password = "1234";

        Member member = Member.builder()
                .username(username)
                .password(encoder.encode(password))
                .role(Role.MEMBER)
                .nickname("nick")
                .birth(now())
                .build();

        JSONObject body = new JSONObject();
        body.put("email", username);
        body.put("password", password);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .post("/api/v1/login")
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        String accessTokenHeader = new JwtProperties().getAccessTokenHeader();

        registerMember(member);

        // when, then
        mockMvc.perform(request)
                .andExpect(status().isOk())
                .andExpect(header().exists(accessTokenHeader));
    }

    @Test
    @DisplayName("이메일 미일치")
    public void loginNotEqualEmail() throws Exception {
        // given
        String username = "qkfka9045@gmail.com";
        String password = "1234";

        Member member = Member.builder()
                .username(username)
                .password(encoder.encode(password))
                .role(Role.MEMBER)
                .nickname("nick")
                .birth(now())
                .build();

        JSONObject body = new JSONObject();
        body.put("email", "nononononononono");
        body.put("password", password);

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .post("/api/v1/login")
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        String accessTokenHeader = new JwtProperties().getAccessTokenHeader();

        registerMember(member);

        // when, then
        mockMvc.perform(request)
                .andExpect(status().is4xxClientError())
                .andExpect(header().doesNotExist(accessTokenHeader));
    }

    @Test
    @DisplayName("비밀번호 미일치")
    public void passwordNotEqualEmail() throws Exception {
        // given
        String username = "qkfka9045@gmail.com";

        Member member = Member.builder()
                .username(username)
                .password(encoder.encode("1234"))
                .role(Role.MEMBER)
                .nickname("nick")
                .birth(now())
                .build();

        JSONObject body = new JSONObject();
        body.put("email", username);
        body.put("password", "nononononononono");

        MockHttpServletRequestBuilder request = MockMvcRequestBuilders
                .post("/api/v1/login")
                .content(body.toString())
                .contentType(MediaType.APPLICATION_JSON);

        String accessTokenHeader = new JwtProperties().getAccessTokenHeader();

        registerMember(member);

        // when, then
        mockMvc.perform(request)
                .andExpect(status().is4xxClientError())
                .andExpect(header().doesNotExist(accessTokenHeader));
    }

    private void registerMember(Member member) {
        if (memberRepository.findByUsername(member.getUsername()).isEmpty()) {
            memberRepository.save(member);
        }
    }
}
