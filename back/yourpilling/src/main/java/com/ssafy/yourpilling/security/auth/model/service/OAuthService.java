package com.ssafy.yourpilling.security.auth.model.service;

import com.nimbusds.oauth2.sdk.AuthorizationSuccessResponse;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKaKaoVo;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKakaoAccessTokenVo;
import com.ssafy.yourpilling.security.auth.model.service.vo.out.OutServerAccessToken;

public interface OAuthService {

    OutServerAccessToken kakao(OAuthKaKaoVo vo);

    OutServerAccessToken serverAccessToken(OAuthKakaoAccessTokenVo vo);

    String requestAccessToken(String code);
}
