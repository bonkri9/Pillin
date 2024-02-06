import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/const/url.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:yourpilling/screen/Main/main_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainStore extends ChangeNotifier {
  var weekData;
  var dailyData;
  var userInventoryData;
  var curCompleteCount = 0;
  var dailyGauge = 0;
  var takenPillIdxList = [];
  var takenOrUnTaken = false;

  // 주간 데이터 복용 기록(주간 Calendar) 데이터 가져오기
  getWeeklyData(BuildContext context) async {
    String accessToken = context.watch<UserStore>().accessToken;
    const String weeklyUrl ="${CONVERT_URL}/api/v1/pill/history/weekly";
    try {
      var response = await http.get(Uri.parse(weeklyUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      print("주간동작");
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
    DateTime koreaTime = DateTime.now().add(Duration(hours: 9));
    String dailyUrl = "${CONVERT_URL}/api/v1/pill/history/daily";
    try {
      var response = await http.get(
          Uri.parse(
              '$dailyUrl?year=${koreaTime.year}&month=${koreaTime.month}&day=${koreaTime.day}'),
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

  // 내 영양제 재고
  getUserInventory(BuildContext context) async{
    String accessToken = context.watch<UserStore>().accessToken;
    String inventoryListUrl = "${CONVERT_URL}/api/v1/pill/inventory/list";
    try {
      var response = await http.get(
        Uri.parse(inventoryListUrl),
        headers: {
          'Content-Type': 'application/json',
          'accessToken': accessToken,
        },
      );
      if (response.statusCode == 200) {
        print("내 영양제 재고 요청 성공");
        userInventoryData = json.decode(utf8.decode(response.bodyBytes))['takeTrue']['data'];
        print('userInventoryData: $userInventoryData');
        notifyListeners();
      } else {
        print("내 영양제 재고 요청 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> takePill(BuildContext context,int ownPillId) async {
    print("영양제 복용 완료 요청");
    print("오운필아이디는? ${ownPillId}");
    const String takePillUrl = "${CONVERT_URL}/api/v1/pill/take";
    print("영양제 복용 완료 요청");
    String accessToken = context.read<UserStore>().accessToken;
    print("엑세스토큰은? ${accessToken}");
    var response = await http.put(Uri.parse(takePillUrl),
        headers: {
          'Content-Type': 'application/json',
          'accessToken': accessToken,
        },
        body: json.encode({
          "ownPillId": ownPillId,
        }));
    print('테이크필');
    if (response.statusCode == 200) {
      print("영양제 복용 완료 요청 수신 성공");
      curCompleteCount++;
      print(response.body);
    } else {
      print(response.body);
      print("영양제 복용 완료 요청 수신 실패");
    }
    notifyListeners();
  }
}