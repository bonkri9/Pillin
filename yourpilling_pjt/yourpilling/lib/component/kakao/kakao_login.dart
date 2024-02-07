import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../store/user_store.dart';

class KakaoLogin extends StatefulWidget {
  const KakaoLogin({super.key});

  @override
  State<KakaoLogin> createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<KakaoLogin> {
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return InkWell(
      onTap: () {
        signInWithKakao(context);
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


  Future<void> signInWithKakao(context) async {
    if (await isKakaoTalkInstalled()) {
      try {
        print(await KakaoSdk.origin);// 이녀석을 애플리케이션 키 해시에 담아야함
        print('출력완료');
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        print('${token.accessToken}');
        await GiveKakaoToken(token.accessToken,context);
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
          await GiveKakaoToken(token.accessToken,context);
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        print('체크3');
        print(await KakaoSdk.origin);
        print('출력완료');
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공 ${token.accessToken}');
        print('${token.accessToken}');
        await GiveKakaoToken(token.accessToken,context);
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }


// 통신추가
  Future<void> GiveKakaoToken(token,context) async {
    // 반환 타입을 'Future<void>'로 변경합니다
    print("카카오엑세스토큰 전달");
    print(token);
    var response = await http.post(Uri.parse('https://i10b101.p.ssafy.io/api/v1/login/oauth2/kakao'),
        headers: {
          'Content-Type': 'application/json',
        },body: json.encode({
          'token' : token,
        }));
    print('카카오 토큰 ${token}');
    print('체크1');
    print(response.body);
    if (response.statusCode == 200) {
      print('카카오토큰을 성공적으로 우리 토큰으로 변한걸 보내고 받음');
      print('변환해서 받은 값 ${response.headers['accesstoken']}');
      _context.read<UserStore>().getToken(response.headers['accesstoken']!);
      print('체크10');
      print("우리 토큰에 할당함");
      print('${_context.read<UserStore>().accessToken}');
      print('토큰값과 비교해보자');
    } else {
      print('카카오토큰을 성공적으로 변환하지 못함');
      print(response.body);
    }
  }

}
//
// Future<void> signInWithKakao(context) async {
//   if (await isKakaoTalkInstalled()) {
//     try {
//       print(await KakaoSdk.origin);// 이녀석을 애플리케이션 키 해시에 담아야함
//       print('출력완료');
//       OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
//       print('카카오톡으로 로그인 성공 ${token.accessToken}');
//       print('${token.accessToken}');
//       await GiveKakaoToken(token.accessToken,context);
//     } catch (error) {
//       print('카카오톡으로 로그인 실패 $error');
//       if (error is PlatformException && error.code == 'CANCELED') {
//         return;
//       }
//       try {
//         print(await KakaoSdk.origin);
//         print('출력완료');
//         OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
//         print('카카오계정으로 로그인 성공 ${token.accessToken}');
//         print('${token.accessToken}');
//         await GiveKakaoToken(token.accessToken,context);
//       } catch (error) {
//         print('카카오계정으로 로그인 실패 $error');
//       }
//     }
//   } else {
//     try {
//       print(await KakaoSdk.origin);
//       print('출력완료');
//       OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
//       print('카카오계정으로 로그인 성공 ${token.accessToken}');
//       print('${token.accessToken}');
//       await GiveKakaoToken(token.accessToken,context);
//     } catch (error) {
//       print('카카오계정으로 로그인 실패 $error');
//     }
//   }
// }
//
//
// // 통신추가
// Future<void> GiveKakaoToken(token,context) async {
//   // 반환 타입을 'Future<void>'로 변경합니다
//   print("카카오엑세스토큰 전달");
//   print(token);
//   var response = await http.post(Uri.parse('https://i10b101.p.ssafy.io/api/v1/login/oauth2/kakao'),
//       headers: {
//         'Content-Type': 'application/json',
//       },body: json.encode({
//         'token' : token,
//       }));
// print('카카오 토큰 ${token}');
//   print('체크1');
//   print(response.body);
//   if (response.statusCode == 200) {
//     print('카카오토큰을 성공적으로 우리 토큰으로 변환함');
//     print('통신온값 ${response.headers['accesstoken']}');
//     print('체크10');
//     _context.read<UserStore>().getToken(response.headers['accesstoken']!);
//     print("우리 토큰에 할당함");
//     // print(context.watch<UserStore>().accessToken);
//     print('토큰값과 비교해보자');
//   } else {
//     print('카카오토큰을 성공적으로 변환하지 못함');
//     print(response.body);
//   }
// }