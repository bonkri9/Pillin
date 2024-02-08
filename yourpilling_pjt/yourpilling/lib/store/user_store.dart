import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:yourpilling/screen/Main/main_screen.dart';
import 'package:yourpilling/screen/SignUp/more_info_screen.dart';

import '../const/url.dart';

class UserStore extends ChangeNotifier {
  String get loginToken => accessToken;

  bool get isLoggedIn => accessToken.isNotEmpty;
  String accessToken = '';
  var UserDetail; // 회원정보 페이지에 뿌려줄 데이터

  // 회원가입 정보
  String userName = '';
  String userEmail = '';
  String password = '';

  // 생년 월일
  String year = '';
  String month = '';
  String day = '';

  // 성별 : enum Type / 남자 : 1, 여자 : 0
  String gender = '';

  setGender(String str) {
    gender = str;
  }

  setYear(String str) {
    year = str;
  }

  setMonth(String str) {
    month = str;
  }

  setDay(String str) {
    day = str;
  }

  getToken(String token) {
    // 로그인할때 발급
    accessToken = token;
    notifyListeners();
  }

  deleteToken() {
    // 로그아웃할때 실행
    accessToken = 'Bearer ...';
    notifyListeners();
  }

  signUp(BuildContext context) async {
    print("회원가입 요청");
    String url = "${CONVERT_URL}/api/v1/register"; // 회원가입 요청 url
    print('${userEmail} $password $userName');
    try {
      var response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'email': userEmail,
            'password': password,
            'name': userName,
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("회원가입 요청 성공");
      } else {
        print("회원가입 요청 실패");
        print(response.body);
      }
    } catch (error) {
      print(error);
    }
  }

  signUpEssential(BuildContext context) async {
    print("생년월일 및 성별 포함 회원가입 요청");
    String url = "${CONVERT_URL}/api/v1/register/essential";
    print('$userEmail $password $userName $year $month $day ${gender}'); // 잘 들어옴

    try {
      print(" accessToken 이야 이게 $accessToken");
      var response = await http.put(Uri.parse(url), headers: {
        'Content-Type' : 'application/json',
        'accessToken' : accessToken,
      }, body: json.encode({
        'email': userEmail,
        'password': password,
        'name': userName,
        'birthday' : '$year-$month-$day',
        'gender' : gender,
      }));

      if (response.statusCode == 200) {
        print("추가 회원가입 요청 성공");
        // 메인 페이지로 이동
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => MainScreen(),
            transitionsBuilder: (c, a1, a2, child) =>
                SlideTransition(
                  position: Tween(
                    begin: Offset(1.0, 0.0),
                    end: Offset(0.0, 0.0),
                  )
                      .chain(CurveTween(curve: Curves.easeInOut))
                      .animate(a1),
                  child: child,
                ),
            transitionDuration: Duration(milliseconds: 750),
          ),
        );

      } else {
        print("추가 회원가입 요청 실패");
        print(response.body);
      }

    } catch (error) {
      print(error);
    }
  }

  // 회원 탈퇴
  deleteUserData(BuildContext context) async {
    String accessToken = this.accessToken;

    String userDeleteUrl = "${CONVERT_URL}/api/v1/member";
    print('url은 ${userDeleteUrl}');
    print('토큰은 ${accessToken}');
    try {
      var response = await http.delete(Uri.parse(userDeleteUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("회원탈퇴 가져오기 성공");

        // MainStore에 응답 저장
      } else {
        print("회원탈퇴 가져오기 실패");
      }
    } catch (error) {
      print("에러발생");
      print(error);
    }
    notifyListeners();
  }

  // 회원 상세정보 가져오기
  getUserDetailData(BuildContext context) async {
    print('체크1');
    String accessToken = this.accessToken;
    print('체크2');
    String url = "${CONVERT_URL}/api/v1/member";

    print('url은 ${url}');
    print('토큰은 ${accessToken}');
    print("상세정보 요청");
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'accessToken': accessToken
    });

    if (response.statusCode == 200) {
      print('상세정보 통신성공');
      UserDetail = jsonDecode(utf8.decode(response.bodyBytes));
      print("DetailData: ${UserDetail}");
      print('체크3');
    } else {
      print(response.body);
      throw http.ClientException(
          '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
    }
    notifyListeners();
  }
// 상세정보 종료
}
