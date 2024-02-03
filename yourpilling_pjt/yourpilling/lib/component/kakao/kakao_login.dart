import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KakaoLogin extends StatefulWidget {
  const KakaoLogin({super.key});

  @override
  State<KakaoLogin> createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<KakaoLogin> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signInWithKakao();
      },
//thing to do

      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        elevation: 2,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/image/kakao_login_medium_wide.png'),
            ),
            borderRadius: BorderRadius.circular(7),
          ), // BoxDecoration
        ), //
      ),
    );

  }
}

Future<void> signInWithKakao() async {
  if (await isKakaoTalkInstalled()) {
    try {
      print(await KakaoSdk.origin);// 이녀석을 애플리케이션 키 해시에 담아야함
      print('출력완료');
      OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공 ${token.accessToken}');
      print('${token.accessToken}');
      GiveKakaoToken(token.accessToken);
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      try {
        print(await KakaoSdk.origin);
        print('출력완료');
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공 ${token.accessToken}');
        print('${token.accessToken}');
        GiveKakaoToken(token.accessToken);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      print(await KakaoSdk.origin);
      print('출력완료');
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
      print('카카오계정으로 로그인 성공 ${token.accessToken}');
      print('${token.accessToken}');
      GiveKakaoToken(token.accessToken);
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}


// 통신추가
Future<void> GiveKakaoToken(token) async {
  // 반환 타입을 'Future<void>'로 변경합니다
  print("카카오엑세스토큰 전달");
  print(token);
  var response = await http.post(Uri.parse('http://i10b101.p.ssafy.io/api/v1/login/oauth2/kakao'),
      headers: {
        'Content-Type': 'application/json',
      },body: json.encode({
        'token' : token,
      }));
print('카카오 토큰 ${token}');
  print('체크1');
  print(response.body);
  print('응답온거');
  if (response.statusCode == 200) {
    print('응답이 똑띠옴');
    print('통신온거 ${response.headers['accesstoken']}');
  } else {
    print(response.body);
    throw http.ClientException(
        '카카오 안왔어요.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
  }
}