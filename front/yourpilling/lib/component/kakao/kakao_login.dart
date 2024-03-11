import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/const/url.dart';
import 'package:yourpilling/screen/SignUp/last_info_screen.dart';
import 'dart:convert';

import '../../screen/Main/main_page_child_screen.dart';
import '../../screen/SignUp/more_info_screen.dart';
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
    var inputWidth = MediaQuery.of(context).size.width * 0.82;
    return InkWell(
      onTap: () async {
        await signInWithKakao(context);
      },
//thing to do

      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow.withOpacity(0.95),
          ),

          width: inputWidth,
          height: 55,
          child: TextButton(
            onPressed: () {signInWithKakao(context);},
            child: Row(
              children: [
                SizedBox(width: 5,),
                Icon(Icons.chat_bubble, color: BASIC_BLACK),
                SizedBox(width: 85,),
                Text("카카오 로그인", style: TextStyle(color: BASIC_BLACK.withOpacity(0.8), fontWeight: FontWeight.w500, fontSize: 15),),
              ],
            ),

          )
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
          print("hii");
          // return;
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
    print("카카오에서 받은 토큰");
    print(token);
    print("주소출력완료");
    var response = await http.post(Uri.parse('${CONVERT_URL}/login/oauth2/kakao'),
        headers: {
          'Content-Type': 'application/json',
        },body: json.encode({
          'token' : token,
        }));
    print("돼지");
    print('카카오에서 받은 토큰 ${token}');
    print('체크1');
    print(response.body);
    print('체크1');
    if (response.statusCode == 200) {

      print('response headers : ${response.headers}');
      String? isFirstLoginStr = response.headers['isfirstlogin'];
      bool isFirstLogin = true;
      print("라스트체크 $isFirstLogin");
      if(isFirstLoginStr != null) {
        isFirstLogin = isFirstLoginStr.toLowerCase() == 'true';
      }
      print("최초로그인 bool값 ${response.headers['isfirstlogin']}");
      print("isFirstLogin값은 $isFirstLogin");
      // print("최초로그인 bool값 ${response.headers['isfirstlogin'].toLowerCase()}");
      print('카카오토큰을 성공적으로 우리 토큰으로 변한걸 보내고 받음');
      print('변환해서 받은 값 ${response.headers['accesstoken']}');
      // context.read<UserStore>().getToken(response.headers['accesstoken']!);
      String tmp = response.headers['accesstoken']!;
      print('체크10 $tmp');
      Provider.of<UserStore>(context, listen: false).getToken(tmp);
      print("우리 토큰에 할당함");
      print('${Provider.of<UserStore>(context, listen: false).accessToken}');
      print('토큰값과 비교해보자');
      // 추가
      print("최초로그인 bool값 ${response.headers['isFirstLogin']}");
      print("라스트트 $isFirstLogin");
      if (isFirstLogin) {
        print("첫번째 로그인임");
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MoreInfoScreen()));
      } else {
        print("첫번째 로그인 아님");
        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPageChild()));
      }
      // 추가 종료
    }
    else {
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