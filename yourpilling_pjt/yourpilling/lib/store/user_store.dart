import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../const/url.dart';

class UserStore extends ChangeNotifier {
  String get loginToken => accessToken;

  bool get isLoggedIn => accessToken.isNotEmpty;
  String accessToken = '';
  var UserDetail; // 회원정보 페이지에 뿌려줄 데이터

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

  // 회원 탈퇴
  Future<void> deleteUserData(BuildContext context) async {
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
  Future<void> getUserDetailData(BuildContext context) async {
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
