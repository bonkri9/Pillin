package com.ssafy.yourpilling.security.auth.jwt;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.dao.jpa.MemberRepository;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Optional;

@Component
@RequiredArgsConstructor
public class JwtManager {

    private final JwtProperties jwtProperties;
    private final MemberRepository memberRepository;

    public String createAccessToken(PrincipalDetails principalDetails) {
        return jwtProperties.getTokenPrefix() +
                JWT.create()
                        .withSubject("token")
                        .withExpiresAt(new Date(System.currentTimeMillis() + jwtProperties.getAccessTokenExpirationTime()))
                        .withClaim("memberId", principalDetails.getMember().getMemberId()) // 발행 유저정보 저장
                        .withClaim("username", principalDetails.getMember().getUsername())
                        .withClaim("role", principalDetails.getMember().getRole().toString())
                        .sign(Algorithm.HMAC512(jwtProperties.getAccessTokenSecret())); //고윳값
    }

    public Optional<String> resolveAccessToken(HttpServletRequest request) {
        return Optional.ofNullable(request.getHeader(jwtProperties.getAccessTokenHeader()));
    }

    public String getUsername(String token) {
        token = token.replace(jwtProperties.getTokenPrefix(), "");

        return JWT.require(Algorithm.HMAC512(jwtProperties.getAccessTokenSecret())).build().verify(token).
                getClaim("username").asString();

    }

    public Authentication getAuthentication(String token) {
        String username = getUsername(token);

        if (username != null) {
            Member user = memberRepository.findByUsername(username)
                    .orElseThrow(() -> new UsernameNotFoundException("JWT 인증 로직에 문제가 생겨 회원을 찾을 수 없습니다."));
            PrincipalDetails principalDetails = new PrincipalDetails(user);
            return new UsernamePasswordAuthenticationToken(principalDetails,
                    principalDetails.getPassword(),
                    principalDetails.getAuthorities());
        }
        return null;
    }

    public boolean isTokenValid(String token) {
        return (getUsername(token) != null && token.startsWith(jwtProperties.getTokenPrefix()));
    }

    public boolean isFirstLogin(String token){
        Member member = memberRepository.findByUsername(getUsername(token))
                .orElseThrow(() -> new IllegalArgumentException("토큰생성이 잘못되어 사용자를 찾을 수 없습니다."));

        return (member.getBirth() == null || member.getGender() == null);
    }
}
