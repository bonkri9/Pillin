package com.ssafy.yourpilling.security.auth.model.service.mapper;

import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.value.KakaoValue;
import com.ssafy.yourpilling.security.auth.model.service.vo.out.OutServerAccessTokenVo;
import org.springframework.stereotype.Component;

@Component
public class OAuthServiceMapper {

    public OutServerAccessTokenVo mapToOutServerAccessToken(String accessToken, boolean isFistLogin){
        return OutServerAccessTokenVo
                .builder()
                .isFirstLogin(isFistLogin)
                .accessToken(accessToken)
                .build();
    }

    public Member memToMember(KakaoValue value){
        return Member
                .builder()
                .username(value.getUsername())
                .name(value.getName())
                .providerId(value.getProviderId())
                .createdAt(value.getCreateAt())
                .role(value.getRole())
                .build();
    }
}
