package com.ssafy.yourpilling.security.auth.model.service.vo.out;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class OutServerAccessTokenVo {
    boolean isFirstLogin;
    String accessToken;
}
