package com.ssafy.yourpilling.security.auth.model.service;

import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKaKaoVo;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKakaoAccessTokenVo;
import com.ssafy.yourpilling.security.auth.model.service.vo.out.OutServerAccessTokenVo;

public interface OAuthService {

    OutServerAccessTokenVo kakao(OAuthKaKaoVo vo);

    OutServerAccessTokenVo serverAccessToken(OAuthKakaoAccessTokenVo vo);

    String requestAccessToken(String code);
}
