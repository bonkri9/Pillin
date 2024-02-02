import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:yourpilling/store/user_store.dart';
import 'dart:convert';

class SearchStore extends ChangeNotifier {
  var SearchData;
  var PillDetail;

  // 이름 검색 리스트 받아오기
  Future<void> getSearchNameData(BuildContext context, name) async {
    print('체크1');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    String url = 'http://10.0.2.2:8080/api/v1/pill/search?pillName=${name}';
    print('url은 ${url}');
    print('토큰은 ${accessToken}');
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("이름 검색 수신 성공");

        // MainStore에 응답 저장
        SearchData = jsonDecode(utf8.decode(response.bodyBytes));
        print("체크3");
        print("SearchData: ${SearchData["data"]}");
      } else {
        print(response.body);
        print("검색기록 불러오기 실패");
      }
    } catch (error) {
      print("에러발생");
      print(error);
    }
    notifyListeners();
  }
  // 이름 검색 종료

  // 성분 검색 리스트 받아오기
  Future<void> getSearchNutrientData(BuildContext context, nutrient) async {
    print('체크1');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    String url = 'http://10.0.2.2:8080/api/v1/pill/search/nutrition?nutritionName=${nutrient}';
    print('url은 ${url}');
    print('토큰은 ${accessToken}');
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("이름 검색 수신 성공");

        // MainStore에 응답 저장
        SearchData = jsonDecode(utf8.decode(response.bodyBytes));
        print("체크3");
        print("SearchData: ${SearchData["data"]}");
      } else {
        print(response.body);
        print("성분 검색기록 불러오기 실패");
      }
    } catch (error) {
      print("에러발생");
      print(error);
    }
    notifyListeners();
  }
// 이름 검색 종료ㅕ

// 건강 검색 리스트 받아오기
  Future<void> getSearchHealthData(BuildContext context, health) async {
    print('체크1');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    String url = 'http://10.0.2.2:8080/api/v1/pill/search/category?healthConcerns=${health}';
    print('url은 ${url}');
    print('토큰은 ${accessToken}');
    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print('영양소 건강고민 통신성공');

        // MainStore에 응답 저장
        SearchData = jsonDecode(utf8.decode(response.bodyBytes));
        print("체크3");
        print("SearchData: ${SearchData["data"]}");
      } else {
        print(response.body);
        print("건강 검색기록 불러오기 실패");
      }
    } catch (error) {
      print("에러발생");
      print(error);
    }
    notifyListeners();
  }
// 건강고민 검색 종료

// 상세정보 검색
  Future<void> getSearchDetailData(BuildContext context, id) async {
    print('체크1');
    print('들어온id는 ${id}');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    String url = 'http://10.0.2.2:8080/api/v1/pill/detail?pillId=${id}';
    print('url은 ${url}');
    print('토큰은 ${accessToken}');
    print("상세정보 요청");
    var response = await http.get(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'accessToken' : accessToken,
        });

    if (response.statusCode == 200) {
      print('상세정보 통신성공');
      PillDetail = jsonDecode(utf8.decode(response.bodyBytes));
      print("DetailhData: ${PillDetail}");
      print('체크3');
    } else {
      print(response.body);
      throw http.ClientException(
          '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
    }
  }
  // 상세정보 종료

}