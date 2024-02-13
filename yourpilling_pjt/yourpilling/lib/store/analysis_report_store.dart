import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/const/url.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:yourpilling/screen/Main/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalysisReportStore extends ChangeNotifier {
  // var curCompleteCount = 0;
  // var takenPillIdxList = [];
  // var takenOrUnTaken = false;

  late List essentialNutrientDataList = [];
  late List vitaminBGroupDataList = [];
  late List recommendList = [];
  var listAll;

  var essentialNutrientDataLisLength;
  var vitaminBGroupDataListLength;
  var recommendListLength;

  // 필수 영양소 정보 데이터 가져오기
  getEssentialNutrientsDataList(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String essentialNutrientsDataListUrl ="${CONVERT_URL}/api/v1/pill/analysis";

    try {
      var response = await http.get(Uri.parse(essentialNutrientsDataListUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("필수 영양소 데이터 수신 성공");
        print(response.body);

        // MainStore에 응답 저장
        listAll = jsonDecode(utf8.decode(response.bodyBytes));
        essentialNutrientDataList = listAll?["essentialNutrientsDataList"] ?? [];
        essentialNutrientDataLisLength = essentialNutrientDataList.length ?? 0;
        print("essentialNutrientDataList: $essentialNutrientDataList");
        print("이게 필수 길이: $essentialNutrientDataLisLength");
      } else {
        print(response.body);
        print("필수 영양소 데이터 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  // 비타민 B군 정보 데이터 가져오기
  getVitaminBGroupDataList(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String vitaminBGroupDataListUrl ="${CONVERT_URL}/api/v1/pill/analysis";

    try {
      var response = await http.get(Uri.parse(vitaminBGroupDataListUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("비타민 B군 정보 데이터 수신 성공");
        print(response.body);

        // MainStore에 응답 저장
        listAll = jsonDecode(utf8.decode(response.bodyBytes));
        vitaminBGroupDataList = listAll?["vitaminBGroupDataList"] ?? [];
        vitaminBGroupDataListLength = vitaminBGroupDataList.length ?? 0;
        print("vitaminBGroupDataList: ${vitaminBGroupDataList}");
        print("이게 B 길이: $vitaminBGroupDataListLength");
      } else {
        print(response.body);
        print("비타민 B군 정보 데이터 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  // 추천리스트 데이터 가져오기
  getRecommendList(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String recommendListUrl ="${CONVERT_URL}/api/v1/pill/analysis";

    try {
      var response = await http.get(Uri.parse(recommendListUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("추천리스트 데이터 수신 성공");
        print(response.body);

        // MainStore에 응답 저장
        listAll = jsonDecode(utf8.decode(response.bodyBytes));
        recommendList = listAll?["recommendList"]?["data"] ?? [];
        recommendListLength = recommendList.length ?? 0;
        print("recommendList: ${recommendList}");
        print("이게 추천 길이: $recommendListLength");
      } else {
        print(response.body);
        print("추천리스트 데이터 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

}