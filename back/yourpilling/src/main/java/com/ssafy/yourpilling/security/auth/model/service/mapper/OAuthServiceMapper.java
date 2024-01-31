package com.ssafy.yourpilling.security.auth.model.service.mapper;

import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.value.KakaoValue;
import com.ssafy.yourpilling.security.auth.model.service.vo.out.OutServerAccessToken;
import org.springframework.stereotype.Component;

@Component
public class OAuthServiceMapper {

    public OutServerAccessToken mapToOutServerAccessToken(String accessToken){
        return OutServerAccessToken
                .builder()
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
