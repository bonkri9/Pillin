import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainStore extends ChangeNotifier {
  var weekData;
  var dailyData;

  // 주간 데이터 복용 기록(주간 Calendar) 데이터 가져오기
  getWeeklyData(BuildContext context) async {
    String accessToken = context.watch<UserStore>().accessToken;
    const String weeklyUrl = 'http://10.0.2.2:8080/api/v1/pill/history/weekly';
    try {
      var response = await http.get(Uri.parse(weeklyUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("주간 복용 기록 수신 성공");
        print(response.body);

        // MainStore에 응답 저장
        weekData = json.decode(response.body);
        print("weekData: ${weekData["data"]}");
      } else {
        print(response.body);
        print("주간 복용 기록 조회 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  // 일간 복용 기록(status Bar) 부분 조회
  getDailyData(BuildContext context) async {
    String accessToken = context.watch<UserStore>().accessToken;
    DateTime now = DateTime.now();
    String dailyUrl = 'http://10.0.2.2:8080/api/v1/pill/history/daily'; // url
    try {
      var response = await http.get(
          Uri.parse(
              '$dailyUrl?year=${now.year}&month=${now.month}&day=${now.day}'),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': accessToken,
          });

      if (response.statusCode == 200) {
        print("일간 복용 기록 수신 성공");

        dailyData = jsonDecode(utf8.decode(response.bodyBytes))['taken'];
        print("dailyData: $dailyData");
      } else {
        print("일간 복용 기록 조회 실패");
        print(response.body);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}