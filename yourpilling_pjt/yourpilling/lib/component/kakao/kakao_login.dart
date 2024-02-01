import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';


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
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
