package com.ssafy.yourpilling.security.auth.controller.mapper;

import com.ssafy.yourpilling.security.auth.controller.dto.RequestKakaoTokenDto;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKaKaoVo;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKakaoAccessTokenVo;
import org.springframework.stereotype.Component;

@Component
public class OAuthControllerMapper {

    public OAuthKaKaoVo mapToKaKaoVo(String code){
        return OAuthKaKaoVo
                .builder()
                .code(code)
                .build();
    }

    public OAuthKakaoAccessTokenVo mapToOAuthKakaoAccessTokenVo(RequestKakaoTokenDto dto) {
        return OAuthKakaoAccessTokenVo
                .builder()
                .kakaoAccessToken(dto.getToken())
                .build();
    }
}
