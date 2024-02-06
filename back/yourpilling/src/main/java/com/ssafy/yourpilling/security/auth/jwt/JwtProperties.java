package com.ssafy.yourpilling.security.auth.jwt;

import lombok.Getter;
import org.springframework.stereotype.Component;

@Component
@Getter
public class JwtProperties {
    private final String accessTokenSecret = "access";
    private final int accessTokenExpirationTime = 1000 * 60 * 60 * 2;
    private final String tokenPrefix = "Bearer ";
    private final String accessTokenHeader = "accessToken";


}

