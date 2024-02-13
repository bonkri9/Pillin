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
  var dailyGauge = 0;
  var takenPillIdxList = [];
  var takenOrUnTaken = false;
  var deadLine = 0;
  int  numerator = 0; // 분자
  int  denominator = 0; // 분모
  // 주간 데이터 복용 기록(주간 Calendar) 데이터 가져오기
  getWeeklyData(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String weeklyUrl = "${CONVERT_URL}/api/v1/pill/history/weekly";

    try {
      var response = await http.get(Uri.parse(weeklyUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("주간 복용 기록 수신 성공");
        print(response.body);

        // MainStore에 응답 저장
        var tmp = json.decode(response.body);
        weekData = tmp["data"];
        print("weekData: $weekData");
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
    String accessToken = context.read<UserStore>().accessToken;
    String dailyUrl = "${CONVERT_URL}/api/v1/pill/history/daily";
    DateTime now = DateTime.now();
    try {
      var response = await http.get(
          Uri.parse(
              '$dailyUrl?year=${now.year}&month=${now.month}&day=${now.day}'),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': accessToken,
          });
      if (response.statusCode == 200) {
        // print("일간 복용 기록 수신 성공, 조회 날짜 : " +
        //     '$dailyUrl?year=${now.year}&month=${now.month}&day=${now.day}');
        dailyData = jsonDecode(utf8.decode(response.bodyBytes))['taken'];
        denominator = 0;
        numerator = 0;
        print("오늘 복용해야하는거 전체 출력 $dailyData");
        for (int i = 0; i < dailyData.length; i++) {
          try {
            num remains = dailyData[i]['remains']; // 재고 남아있는 수
            num takeCount = dailyData[i]['needToTakeTotalCount']; // 하루에 먹어야하는 총 갯수
            num tmp = dailyData[i]['actualTakeCount']; // 그날 먹은 먹은 갯수

            // 분모 연산
            if (remains != null && takeCount != null) {
              int remainsInt = remains.toInt();
              int takeCountInt = takeCount.toInt();
              int tmpInt = tmp.toInt();
              if (remainsInt != null && takeCountInt != null) {
                if (tmpInt != takeCountInt && remainsInt <= takeCountInt) { // 리메인즈가 니드투보다 적으면
                  denominator += remainsInt; // 리메인즈
                  denominator += tmpInt; // 액츄얼
                } else {
                  denominator += takeCountInt; // 니드투
                }
              }
            }

            // 분자연산
            if (remains != null && tmp != null) {
              int tmpInt = tmp.toInt();
              if (tmpInt != null) {
                  numerator += tmpInt; // 먹은 갯수를 추가
              }
            }
          } catch (e) {
            print("Error at index $i: $e");
          }
        }
        print("분자는 $numerator");
        print("분모는 $denominator");
        notifyListeners();
      } else {
        print("일간 복용 기록 조회 실패");
        print(response.body);
      }
    } catch (error) {
      print(error);
    }
  }

  // 미복용 => 복용
  takePill(BuildContext context, ownPillId) async {
    const String takePillUrl = "${CONVERT_URL}/api/v1/pill/take";
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
      print("복용버튼 DailyData $dailyData");
      await getDailyData(context);
      notifyListeners();
      print(response.body);
    } else {
      print(response.body);
      print("영양제 복용 완료 요청 수신 실패");
    }
    notifyListeners();
  }

  // 내 영양제 재고
  getUserInventory(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
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
        userInventoryData =
        json.decode(utf8.decode(response.bodyBytes))['takeTrue']['data'];
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
}
