package com.ssafy.yourpilling.security.auth.controller;

import com.ssafy.yourpilling.security.auth.controller.dto.RequestKakaoTokenDto;
import com.ssafy.yourpilling.security.auth.controller.mapper.OAuthControllerMapper;
import com.ssafy.yourpilling.security.auth.jwt.JwtProperties;
import com.ssafy.yourpilling.security.auth.model.service.OAuthService;
import com.ssafy.yourpilling.security.auth.model.service.vo.out.OutServerAccessTokenVo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/login/oauth2")
public class OAuthController {

    private final OAuthControllerMapper mapper;
    private final OAuthService oAuthService;
    private final JwtProperties jwtProperties;

    @GetMapping("/kakao/onlykakaoaccesstoken")
    ResponseEntity<String> kakaoOnlyAccessToken(@RequestParam String code){
        String kakaoAccessToken = oAuthService.requestAccessToken(code);
        return ResponseEntity.ok(kakaoAccessToken);
    }

    @GetMapping("/kakao")
    ResponseEntity<Void> kakaoCode(@RequestParam String code){
        String serverAccessToken = oAuthService.kakao(mapper.mapToKaKaoVo(code)).getAccessToken();
        return ResponseEntity
                .ok()
                .header(jwtProperties.getAccessTokenHeader(), serverAccessToken)
                .build();
    }

    @PostMapping("/kakao")
    ResponseEntity<Void> kakaoAccessToken(@RequestBody RequestKakaoTokenDto dto){
        OutServerAccessTokenVo vo = oAuthService.serverAccessToken(mapper.mapToOAuthKakaoAccessTokenVo(dto));

        return ResponseEntity
                .ok()
                .header(jwtProperties.getAccessTokenHeader(), vo.getAccessToken())
                .header("isFisrtLogin", String.valueOf(vo.isFirstLogin()))
                .build();
    }
}
