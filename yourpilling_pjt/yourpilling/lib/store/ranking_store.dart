import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/store/user_store.dart';
import 'dart:convert';
import '../const/url.dart';
class RankingStore extends ChangeNotifier {
  var CategoriData = [];
  var RankingData = [];
  var RankingIndex;
  var ShowData;

  Future<void> getShowData(index) async {
    for (var data in RankingData) {
      if (data['midCategoryId'] == index) {
        ShowData = RankingData[index]['outRankData'];
        break;
      }
    }
    // print("카테고리 전체 데이터입니다 ${CategoriData}");
    // print("카테고리 데이터 입니다 ${CategoriData[0]['midCategories']}");
    notifyListeners();
  }



// 카테고리 데이터
  Future<void> getCategoriData(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    String url = "${CONVERT_URL}/api/v1/rank/categories";
    print('url은 ${url}');
    print('카테고리 토큰은 ${accessToken}');

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'accessToken': accessToken,
    });

    print("반환값출력완료");
    if (response.statusCode == 200) {
      print("categories 검색 수신 성공");
      // MainStore에 응답 저장
      // dailyData[i]['actualTakeCount']
      var categoriesData = jsonDecode(utf8.decode(response.bodyBytes));
      CategoriData = categoriesData['categoires'];
      // print("카테고리 전체 데이터입니다 ${CategoriData}");
      // print("카테고리 데이터 입니다 ${CategoriData[0]['midCategories']}");
    } else {
      print(response.body);
      throw Exception('검색 결과가 없습니다');
    }
    notifyListeners();
  }



// 랭킹 데이터
  Future<void> getRankingData(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    print('랭킹');
    String url = "${CONVERT_URL}/api/v1/rank";
    print('url은 ${url}');
    print('토큰은 ${accessToken}');

    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'accessToken': accessToken,
    });
    print("반환값출력완료");
    if (response.statusCode == 200) {
      print("랭킹 검색 수신 성공");
      // MainStore에 응답 저장
      var Rankingdata = jsonDecode(utf8.decode(response.bodyBytes));
      print("체크3");
      RankingData = Rankingdata['data'];
      print("랭킹 데이터 입니다: ${RankingData}");
      getShowData(CategoriData[0]['midCategories'][0]['midCategoryId']);
    } else {
      print(response.body);
      throw Exception('랭킹 결과가 없습니다');
    }
  }



}