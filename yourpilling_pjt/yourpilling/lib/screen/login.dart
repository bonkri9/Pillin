import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class kakaoLogin extends StatefulWidget {
  const kakaoLogin ({super.key});

  @override
  State<kakaoLogin> createState() => _kakaoLoginState();
}

class _kakaoLoginState extends State<kakaoLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          getKakaoLoginButton(),
        ],
      ),
    );
  }
}

Future<void> signInWithKakao() async {
  if (await isKakaoTalkInstalled()) {
    try {
      print(await KakaoSdk.origin);
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

Widget getKakaoLoginButton() {
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
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(7),
        ), // BoxDecoration
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/image/kakao_login_medium_wide.png', height: 30),

        ]), // Row
      ), //
    ),
  );
}
