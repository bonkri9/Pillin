import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:yourpilling/screen/main_screen.dart';
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
  var ownPillId;

  // 주간 데이터 복용 기록(주간 Calendar) 데이터 가져오기
  getWeeklyData(BuildContext context) async {
    String accessToken = context.watch<UserStore>().accessToken;
    // const String weeklyUrl = 'https://i10b101.p.ssafy.io/api/v1/pill/history/weekly';
    // const String weeklyUrl ="http://localhost:8080/api/v1/pill/history/weekly";
    const String weeklyUrl ="http://10.0.2.2:8080/api/v1/pill/history/weekly";

    try {
      var response = await http.get(Uri.parse(weeklyUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("주간 복용 기록 수신 성공");
        // MainStore에 응답 저장
        weekData = json.decode(response.body);
        notifyListeners();
      } else {
        print("주간 복용 기록 조회 실패");
      }
    } catch (error) {
    }

  }

  // 일간 복용 기록(status Bar) 부분 조회
  getDailyData(BuildContext context) async {
    String accessToken = context.watch<UserStore>().accessToken;
    DateTime koreaTime = DateTime.now().add(Duration(hours: 9));
    // String dailyUrl = 'https://i10b101.p.ssafy.io/api/v1/pill/history/daily'; // url
    // String dailyUrl = "http://localhost:8080/api/v1/pill/history/daily";
    // String dailyUrl = "http://192.168.31.21:8080/api/v1/pill/history/daily";
    String dailyUrl = "http://10.0.2.2:8080/api/v1/pill/history/daily";

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
        notifyListeners();

        // 게이지 바 계산
        int tmpCnt = 0;
        for (int i = 0; i < dailyData.length; i++) {
          if (dailyData[i]['actualTakeCount'] == dailyData[i]['needToTakeTotalCount']) {
            tmpCnt++;
          }
        }

        curCompleteCount = tmpCnt;
        notifyListeners();


      } else {
        print("일간 복용 기록 조회 실패");
      }
    } catch (error) {
    }
  }

  // 내 영양제 재고
  getUserInventory(BuildContext context) async{
    String accessToken = context.watch<UserStore>().accessToken;
    // String inventoryListUrl =
    //     "https://i10b101.p.ssafy.io/api/v1/pill/inventory/list";
    // String inventoryListUrl = "http://localhost:8080/api/v1/pill/inventory/list";
    // String inventoryListUrl = "http://192.168.31.21:8080/api/v1/pill/inventory/list";
    String inventoryListUrl = "http://10.0.2.2:8080/api/v1/pill/inventory/list";

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
        notifyListeners();
      } else {
        print("내 영양제 재고 요청 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  takePill(BuildContext context) async {
    // const String putPillTakeUrl = "https://i10b101.p.ssafy.io/api/v1/pill/take";
    // const String putPillTakeUrl = "http://localhost:8080/api/v1/pill/take";
    // const String takePillUrl = "http://192.168.31.21:8080/api/v1/pill/take";
    const String takePillUrl = "http://10.0.2.2:8080/api/v1/pill/take";

    print("영양제 복용 완료 요청");
    String accessToken = context.read<UserStore>().accessToken;
    var response = await http.put(Uri.parse(takePillUrl),
        headers: {
          'Content-Type': 'application/json',
          'accessToken': accessToken,
        },
        body: json.encode({
          "ownPillId": ownPillId,
        }));
    if (response.statusCode == 200) {
      print("영양제 복용 완료 요청 수신 성공");
      curCompleteCount++;
      notifyListeners();
      // 주간 복용 현황도 업데이트 되어야 함
      getWeeklyData(context);
      notifyListeners();
    } else {
      print("영양제 복용 완료 요청 수신 실패");
    }
    // MainScreen().today.createState();
    notifyListeners();
  }
}