import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecordStore extends ChangeNotifier {
  var monthlyData; // 월간 기록 데이터
  var pillListOfTheDay = []; // 해당 날짜에 먹은 영양제 기록들

// 월간 기록 데이터 조회
  getMonthlyData(BuildContext context) async {
    print("월간 기록 데이터 조회 요청");
    // const String url = "http://10.0.2.2:8080/api/v1/pill/history/monthly";
    // const String url = "http://localhost:8080/api/v1/pill/history/monthly";
    const String url = "http://localhost:8080/api/v1/pill/history/monthly";
    DateTime now = DateTime.now();
    String accessToken = context.watch<UserStore>().accessToken;
    try {
      var response = await http.get(
        Uri.parse('$url?year=${now.year}&month=${now.month}'), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      },);

      if (response.statusCode == 200) {
        print("response 월간 기록 데이터 수신 성공");
        monthlyData = jsonDecode(utf8.decode(response.bodyBytes))['data'];
        print('월간데이터 조회 :: $monthlyData');
      } else {
        print(response.body);
        print("월간 기록 데이터 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}