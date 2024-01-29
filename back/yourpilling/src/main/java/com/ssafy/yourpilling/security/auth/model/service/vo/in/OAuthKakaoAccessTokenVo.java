package com.ssafy.yourpilling.security.auth.model.service.vo.in;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OAuthKakaoAccessTokenVo {
    String kakaoAccessToken;
}
