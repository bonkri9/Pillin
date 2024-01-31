package com.ssafy.yourpilling.security.auth.model.service.impl;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.ssafy.yourpilling.common.Role;
import com.ssafy.yourpilling.security.auth.PrincipalDetails;
import com.ssafy.yourpilling.security.auth.jwt.JwtManager;
import com.ssafy.yourpilling.security.auth.model.dao.OAuthDao;
import com.ssafy.yourpilling.security.auth.model.dao.entity.Member;
import com.ssafy.yourpilling.security.auth.model.service.OAuthService;
import com.ssafy.yourpilling.security.auth.model.service.mapper.OAuthServiceMapper;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKaKaoVo;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.OAuthKakaoAccessTokenVo;
import com.ssafy.yourpilling.security.auth.model.service.vo.in.value.KakaoValue;
import com.ssafy.yourpilling.security.auth.model.service.vo.out.OutServerAccessToken;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.util.Optional;

import static java.time.LocalDateTime.now;

@Service
@Transactional(readOnly = true)
@RequiredArgsConstructor
public class OAuthServiceImpl implements OAuthService {

    @Value("${spring.oauth.kakao.client-id}")
    private String clientId;

    @Value("${spring.oauth.kakao.redirect-uri}")
    private String redirectUri;

    @Value("${spring.oauth.kakao.grant_type}")
    private String authorizationCode;

    private final OAuthDao oAuthDao;
    private final OAuthServiceMapper mapper;
    private final JwtManager jwtManager;

    @Override
    public OutServerAccessToken serverAccessToken(OAuthKakaoAccessTokenVo vo) {
        JsonObject kakaoMemberInfo = requestKaKaoMemberInfo(vo.getKakaoAccessToken());

        Optional<Member> member = oAuthDao.findByUsername(getUsername(kakaoMemberInfo));

        // 신규이면 회원가입
        if(member.isEmpty()){
            Member newMember = mapper.memToMember(toKakaoValue(kakaoMemberInfo));
            oAuthDao.register(newMember);

            member = Optional.of(newMember);
        }

        return mapper.mapToOutServerAccessToken(createAccessToken(member.get()));
    }

    @Transactional
    @Override
    public OutServerAccessToken kakao(OAuthKaKaoVo vo) {
        JsonObject kakaoMemberInfo = requestKaKaoMemberInfo(requestAccessToken(vo.getCode()));

        Optional<Member> member = oAuthDao.findByUsername(getUsername(kakaoMemberInfo));

        // 신규이면 회원가입
        if(member.isEmpty()){
            Member newMember = mapper.memToMember(toKakaoValue(kakaoMemberInfo));
            oAuthDao.register(newMember);

            member = Optional.of(newMember);
        }

        return mapper.mapToOutServerAccessToken(createAccessToken(member.get()));
    }

    private String createAccessToken(Member member){
        return jwtManager.createAccessToken(new PrincipalDetails(member));
    }

    private KakaoValue toKakaoValue(JsonObject jsonObject){
        return KakaoValue
                .builder()
                .providerId(getProviderId(jsonObject))
                .username(getUsername(jsonObject))
                .name(getName(jsonObject))
                .role(Role.MEMBER)
                .createAt(now())
                .build();
    }

    private String getProviderId(JsonObject jsonObject){
        return "kakao_" + jsonObject.get("id").getAsString();
    }

    private String getUsername(JsonObject jsonObject){
        return jsonObject.getAsJsonObject("kakao_account").get("email").getAsString();
    }

    private String getName(JsonObject jsonObject){
        return jsonObject.getAsJsonObject("kakao_account").getAsJsonObject("profile").get("nickname").getAsString();
    }

    private JsonObject requestKaKaoMemberInfo(String accessToken) {
        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
        headers.add("Authorization", "Bearer " + accessToken);

        MultiValueMap<String, String> params = getMemberInfoForm();
        HttpEntity<MultiValueMap<String, String>> kakaoMemberInfoRequest = new HttpEntity<>(params, headers);
        ResponseEntity<String> reponse = rt.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.POST, // 요청할 방식
                kakaoMemberInfoRequest, // 요청할 때 보낼 데이터
                String.class // 요청 시 반환되는 데이터 타입
        );

        return JsonParser.parseString(reponse.getBody()).getAsJsonObject();
    }

    public String requestAccessToken(String code){
        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        MultiValueMap<String, String> params = getAccessTokenForm(code);

        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

        ResponseEntity<String> reponseKaKaoAccessToken = rt.exchange(
                "https://kauth.kakao.com/oauth/token",
                HttpMethod.POST, // 요청할 방식
                kakaoTokenRequest, // 요청할 때 보낼 데이터
                String.class // 요청 시 반환되는 데이터 타입
        );
        return accessToken(reponseKaKaoAccessToken);
    }

    private String accessToken(ResponseEntity<String> getKaKaoAccessToken) {
        String body = getKaKaoAccessToken.getBody();
        JsonObject jsonObject = JsonParser.parseString(body).getAsJsonObject();

        return jsonObject.get("access_token").getAsString();
    }

    private MultiValueMap<String, String> getAccessTokenForm(String code){
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", authorizationCode);
        params.add("client_id", clientId);
        params.add("redirect_uri", redirectUri);
        params.add("code", code);

        return params;
    }

    private MultiValueMap<String, String> getMemberInfoForm(){
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("property_keys", "[\"kakao_account.profile\",\"kakao_account.name\",\"kakao_account.email\"]");
        return params;
    }
}
