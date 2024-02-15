import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/store/user_store.dart';
import 'dart:convert';

import '../const/url.dart';

class SearchStore extends ChangeNotifier {
  var searchData;
  var pillDetailData;
  var isInMyInventory = false;

  setHaveTrue() {
    isInMyInventory = true;
  }

  setHaveFalse() {
    isInMyInventory = false;
  }

  // 이름 검색 리스트 받아오기
  Future<void> getSearchNameData(BuildContext context, name) async {
    print('체크1');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    String url = "${CONVERT_URL}/api/v1/pill/search?pillName=${name}";

    print('url은 ${url}');
    print('토큰은 ${accessToken}');

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'accessToken': accessToken,
    });

    if (response.statusCode == 200) {
      print("이름 검색 수신 성공");
      // MainStore에 응답 저장
      searchData = jsonDecode(utf8.decode(response.bodyBytes));
      print("체크3");
      print("searchData: ${searchData["data"]}");
    } else {
      print(response.body);
      throw Exception('검색 결과가 없습니다');
    }

    notifyListeners();
  }
  // 이름 검색 종료

  // 성분 검색 리스트 받아오기
  Future<void> getSearchNutrientData(BuildContext context, nutrient) async {
    print('체크1');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    // String url = 'https://i10b101.p.ssafy.io/api/v1/pill/search/nutrition?nutritionName=${nutrient}';


    // String url = "${CONVERT_URL}/api/v1/pill/search/nutrition?nutritionName=${nutrient}";
    String url = "${CONVERT_URL}/api/v1/pill/search/nutrition?nutritionName=${nutrient}";

    print('url은 ${url}');
    print('토큰은 ${accessToken}');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("이름 검색 수신 성공");

        // MainStore에 응답 저장
        searchData = jsonDecode(utf8.decode(response.bodyBytes));
        print("체크3");
        print("searchData: ${searchData["data"]}");
      } else {
        print(response.body);
        print("성분 검색기록 불러오기 실패");
        throw Exception('성분 검색 결과가 없습니다');
      }

    notifyListeners();
  }
// 이름 검색 종료ㅕ

// 건강 검색 리스트 받아오기
  Future<void> getSearchHealthData(BuildContext context, health) async {
    print('체크1');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    String url = "${CONVERT_URL}/api/v1/pill/search/category?healthConcerns=${health}";

    print('url은 ${url}');
    print('토큰은 ${accessToken}');

      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print('영양소 건강고민 통신성공');

        // MainStore에 응답 저장
        searchData = jsonDecode(utf8.decode(response.bodyBytes));
        print("체크3");
        print("SearchData: ${searchData["data"]}");
      } else {
        print(response.body);
        print("건강 검색기록 불러오기 실패");
        throw Exception('건강 검색 결과가 없습니다');
      }

    notifyListeners();
  }



  //재고 상세 조회
  getSearchDetailData(BuildContext context, var pillId) async {
    String accessToken = context.watch<UserStore>().accessToken;
    const String pillDetailUrl = "${CONVERT_URL}/api/v1/pill/detail";
    try {
      var response = await http.get(Uri.parse('$pillDetailUrl?pillId=$pillId'),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': accessToken,
          });

      if (response.statusCode == 200) {
        print("검색 상세 get 수신 성공");
        // print(response.body);

        // InventoryStore에 응답 저장
        pillDetailData = jsonDecode(utf8.decode(response.bodyBytes));
        print('이걸 보세요 ㄹㅇ ${pillDetailData['alreadyHave']}');
        if (pillDetailData['alreadyHave']) {
          print("보유중");
          setHaveTrue();
        } else {
          print("보유중 아님");
          setHaveFalse();
        }
      } else {
        // print(response.body);
        print("검색 상세 get 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  //네이버 스토어 영양제별 클릭 횟수
  Future<void> postBuyClick(BuildContext context, var pillId ) async {
    print("클릭횟수 도착");
    String accessToken = context.read<UserStore>().accessToken;
    const String postBuyClickUrl = "${CONVERT_URL}/api/v1/pill/buy";
    var response = await http.post(Uri.parse(postBuyClickUrl),
        headers: {
          'Content-Type': 'application/json',
          'accessToken': accessToken,
        },
        body: json.encode({
          'pillId': pillId,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      print("구매 클릭 post 수신 성공");
      print(response.body);
    } else {
      print(response.body);
      print("구매 클릭 post 수신 실패");
      throw Error();
    }

    notifyListeners();
  }

}


class SearchRepository extends ChangeNotifier {
  var BuyLink;
  var BuyList;
  static final SearchRepository instance = SearchRepository._internal();
  factory SearchRepository() => instance;
  SearchRepository._internal();

  Future<void> getNaverBlogSearch(var pillName) async {
    const String naverBuyLink = "https://openapi.naver.com/v1/search/shop";
    try {
      var response = await http.get(Uri.parse('$naverBuyLink.json?query=$pillName&sort=asc&display=5'),
      // http.Response response = await http.get(
      //     Uri.parse("https://openapi.naver.com/v1/search/blog.json?query=$pillName&sort=asc&display=5"),
          headers: {
            "X-Naver-Client-Id": 'aTVc3C2YUaL3MXMWjDpx',
            "X-Naver-Client-Secret": '6nXh1nAdTj',
          });
      if (response.statusCode == 200) {
        print('네이버 연결 성공');
        BuyList = jsonDecode(utf8.decode(response.bodyBytes));
        BuyLink = BuyList?['items']?[0]?['link'] ?? 0;
        print(BuyLink);
        print(BuyList);
        final url = Uri.parse(BuyLink);
        if (await canLaunchUrl(url)) {
          launchUrl(url, mode: LaunchMode.externalApplication);
        }
        // logger.e(_response.body);
      }else {
        // print(response.body);
        print('네이버 연결 실패');
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }


}