import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/store/user_store.dart';
import 'dart:convert';

import '../const/url.dart';
import 'inventory_store.dart';

class AlarmStore extends ChangeNotifier {
  var AlarmList;
  late DateTime selectTime;
  // late int selectCount;
  late List<bool> selectWeek;
  var pushData = [];

  setTime(DateTime time) {
    selectTime = time;
    print("설정된 시간");
    print(selectTime.hour);
    print(selectTime.minute);
    notifyListeners();
  }

  // setCount(int count) {
  //   selectCount = count;
  //   print("설정된 개수");
  //   print(selectCount);
  //   notifyListeners();
  // }

  setWeek(List<bool> days){
    selectWeek = days;
    print("설정된 요일별");
    print(selectWeek);
    notifyListeners();
  }

  // 알람 사진으로 띄울 리스트 받아오기
  Future<void> getAlarmListData(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String takeYnListUrl = "${CONVERT_URL}/api/v1/pill/inventory/list";
    try {
      var response = await http.get(Uri.parse(takeYnListUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });
      print('response 이거임 $response');
      if (response.statusCode == 200) {
        print("알람 리스트 수신 성공");
        // print(response.body);
        // InventoryStore에 응답 저장
        var tmp = jsonDecode(utf8.decode(response.bodyBytes));
        AlarmList = tmp['takeTrue']["data"];
        print("저장한 알람 데이터는?? ${AlarmList['takeTrue']["data"]}");
      } else {
        // print(response.body);
        print("재고 복용 목록 get 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
// 알림 리스트 가져오기


  //푸시알람 등록
  Future<void> postPushAlarm(BuildContext context,id,name) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String URL = "${CONVERT_URL}/api/v1/push/notification";
    try {
      var response = await http.post(Uri.parse(URL), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      },body: jsonEncode({
        "ownPillId" : id,
        "ownPillName" : name,
        "day" : selectWeek,
        "hour" : selectTime.hour,
        "minute" : selectTime.minute
      }));
      print('response 이거임 $response');
      if (response.statusCode == 200) {
        print("푸시알람 등록 성공");
      } else {
        // print(response.body);
        print("푸시알람 등록 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  //푸시알림 정보 가져오기
  Future<void> getPushAlarm(BuildContext context) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String URL = "${CONVERT_URL}/api/v1/push/notification";

    var response = await http.get(Uri.parse(URL), headers: {
      'Content-Type': 'application/json',
      'accessToken': accessToken,
    });
    print('수신 response 이거임 $response');
    if (response.statusCode == 200) {
      print("푸시알람 수신 성공");
      var tmp = jsonDecode(utf8.decode(response.bodyBytes));
      pushData = tmp['data'];
      // print(pushData[0]['514']['days']);
      print(pushData);
      print("푸시알람 출력");
    } else {
      // print(response.body);
      print("푸시알람 수신 실패");
    }

    notifyListeners();
  }
  // 푸시알림 정보 가져오기 끝

  //푸시알림 정보 삭제하기
  Future<void> deletePushAlarm(BuildContext context,int pushId) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String URL = "${CONVERT_URL}/api/v1/push/notification";
    print("삭제하려는 pushId는 ${pushId}");

    var response = await http.delete(Uri.parse(URL), headers: {
      'Content-Type': 'application/json',
      'accessToken': accessToken,
    },body: jsonEncode({
      "pushId": pushId
    }));
    print('수신 response 이거임 $response');
    if (response.statusCode == 200) {
      print("푸시알람 삭제 성공");
      getPushAlarm(context);
    } else {
      // print(response.body);
      print("푸시알람 삭제 실패");
    }

    notifyListeners();
  }

  //푸시알림 정보 수정하기
  Future<void> updatePushAlarm(BuildContext context,int pushId) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String URL = "${CONVERT_URL}/api/v1/push/notification";
    print("삭제하려는 pushId는 ${pushId}");

    var response = await http.put(Uri.parse(URL), headers: {
      'Content-Type': 'application/json',
      'accessToken': accessToken,
    },body: jsonEncode({
      "pushId" : pushId,
      "day" : selectWeek,
      "hour" : selectTime.hour,
      "minute" : selectTime.minute

    }));
    print('수신 response 이거임 $response');
    if (response.statusCode == 200) {
      print("푸시알림 수정 성공");
      getPushAlarm(context);
    } else {
      // print(response.body);
      print("푸시알람 수정 실패");
    }

    notifyListeners();
  }
}
