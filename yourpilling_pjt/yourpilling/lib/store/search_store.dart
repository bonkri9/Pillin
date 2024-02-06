import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/store/user_store.dart';
import 'dart:convert';

class SearchStore extends ChangeNotifier {
  var SearchData;
  var PillDetailData;


  // 이름 검색 리스트 받아오기
  Future<void> getSearchNameData(BuildContext context, name) async {
    print('체크1');
    String accessToken = context.read<UserStore>().accessToken;
    print('체크2');
    // String url = 'https://i10b101.p.ssafy.io/api/v1/pill/search?pillName=${name}';
    // String url = "http://localhost:8080/api/v1/pill/search?pillName=${name}";
    String url = "http://localhost:8080/api/v1/pill/search?pillName=${name}";
    print('url은 ${url}');
    print('토큰은 ${accessToken}');

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
    // String url = "http://localhost:8080/api/v1/pill/search/nutrition?nutritionName=${nutrient}";
    // String url = "http://192.168.31.21:8080/api/v1/pill/search/nutrition?nutritionName=${nutrient}";
    String url = "http://10.0.2.2:8080/api/v1/pill/search/nutrition?nutritionName=${nutrient}";

    print('url은 ${url}');
    print('토큰은 ${accessToken}');

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
    // String url = 'https://i10b101.p.ssafy.io/api/v1/pill/search/category?healthConcerns=${health}';
    // String url = "http://localhost:8080/api/v1/pill/search/category?healthConcerns=${health}";
    // String url = "http://192.168.31.21:8080/api/v1/pill/search/category?healthConcerns=${health}";
    String url = "http://10.0.2.2:8080/api/v1/pill/search/category?healthConcerns=${health}";

    print('url은 ${url}');
    print('토큰은 ${accessToken}');

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
        throw Exception('건강 검색 결과가 없습니다');
      }

    notifyListeners();
  }

  //localhost:8080
// 건강고민 검색 종료

// 상세정보 검색
//   Future<void> getSearchDetailData(BuildContext context, id) async {
//     print('체크1');
//     print('들어온id는 ${id}');
//     String accessToken = context.read<UserStore>().accessToken;
//     print('체크2');
//     String url = 'http://10.0.2.2:8080/api/v1/pill/detail?pillId=${id}';
//     print('url은 ${url}');
//     print('토큰은 ${accessToken}');
//     print("상세정보 요청");
//     var response = await http.get(Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           'accessToken' : accessToken,
//         });
//
//     if (response.statusCode == 200) {
//       print('상세정보 통신성공');
//       PillDetail = jsonDecode(utf8.decode(response.bodyBytes));
//       print("DetailhData: ${PillDetail}");
//       print('체크3');
//     } else {
//       print(response.body);
//       throw http.ClientException(
//           '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
//     }
//   }
  // 상세정보 종료

  //재고 상세 조회
  getSearchDetailData(BuildContext context, var pillId) async {
    String accessToken = context.watch<UserStore>().accessToken;
    // const String pillDetailUrl = "https://i10b101.p.ssafy.io/api/v1/pill/detail";
    // const String pillDetailUrl = "http://localhost:8080/api/v1/pill/detail";
    // const String pillDetailUrl = "http://192.168.31.21:8080/api/v1/pill/detail";
    const String pillDetailUrl = "http://10.0.2.2:8080/api/v1/pill/detail";

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
        PillDetailData = jsonDecode(utf8.decode(response.bodyBytes));

        // print(PillDetailData);
      } else {
        // print(response.body);
        print("검색 상세 get 수신 실패");
      }
    } catch (error) {
      print(error);
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