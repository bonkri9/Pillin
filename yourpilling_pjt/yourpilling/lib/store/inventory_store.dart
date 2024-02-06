import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../const/url.dart';

class InventoryStore extends ChangeNotifier {
  var takeYnListData;
  List get takeTrueListData => takeYnListData['takeTrue']['data'];
  List get takeFalseListData => takeYnListData['takeFalse']['data'];
  var remains;
  var totalCount;
  var ownPillId;
  var invenDetailData;
  var takeYnData;
  var takeYn;
  var length;

  //복용하는 영양제 전체 리스트 데이터 가져오기
  Future<void> getTakeYnListData(BuildContext context) async {
    String accessToken = context.watch<UserStore>().accessToken;
    // const String takeYnListUrl =
    //     'https://i10b101.p.ssafy.io/api/v1/pill/inventory/list';


    // const String takeYnListUrl = "${CONVERT_URL}/api/v1/pill/inventory/list";
    const String takeYnListUrl = "${CONVERT_URL}/api/v1/pill/inventory/list";


    try {
      var response = await http.get(Uri.parse(takeYnListUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      print('response 이거임 $response');
      if (response.statusCode == 200) {
        print("재고 복용 목록 get 수신 성공");
        // print(response.body);

        // InventoryStore에 응답 저장
        takeYnListData = jsonDecode(utf8.decode(response.bodyBytes));
        length = takeTrueListData.length;
      } else {
        // print(response.body);
        print("재고 복용 목록 get 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  //재고 수정
  Future<void> reviseInven(
      BuildContext context, var ownPillId, var remains, var totalCount) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String reviseUrl = "${CONVERT_URL}/api/v1/pill/inventory";


    try {
      var response = await http.put(Uri.parse(reviseUrl),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': accessToken,
          },
          body: json.encode({
            'ownPillId': ownPillId,
            'remains': remains,
            'totalCount': totalCount,
          }));

      if (response.statusCode == 200) {
        print("재고 수정 put 수신 성공");
        takeYnListData = jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        // print(response.body);
        print("재고 수정 put 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  //재고 상세 조회
  Future<void> getPillDetailData(BuildContext context, var ownPillId) async {
    String accessToken = context.watch<UserStore>().accessToken;
    const String invenDetailUrl = "${CONVERT_URL}/api/v1/pill/inventory";


    try {
      var response = await http
          .get(Uri.parse('$invenDetailUrl?ownPillId=$ownPillId'), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("재고 상세 get 수신 성공");
        // print(response.body);

        // InventoryStore에 응답 저장
        invenDetailData = jsonDecode(utf8.decode(response.bodyBytes));

        // print(invenDetailData);
      } else {
        // print(response.body);
        print("재고 상세 get 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  //섭취&미섭취 전환
  Future<void> putTakeYnChange(BuildContext context, var ownPillId) async {
    String accessToken = context.read<UserStore>().accessToken;
   const String takeYnChangeUrl = "${CONVERT_URL}/api/v1/pill/inventory/take-yn";

    try {
      var response = await http.put(Uri.parse(takeYnChangeUrl),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': accessToken,
          },
          body: json.encode({
            'ownPillId': ownPillId,
          }));

      if (response.statusCode == 200) {
        print("재고 복용 전환 put 수신 성공");
        // print(response.body);

        // InventoryStore에 응답 저장
        takeYnData = jsonDecode(utf8.decode(response.bodyBytes));
        // takeTrueListData = takeYnListData['takeTrue']['data'];
        length = takeTrueListData.length;
        // return takeTrueListData;
        // print(takeYnData);
      } else {
        // print(response.body);
        print("재고 복용 전환 put 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  //재고 등록
  Future<void> registInven(BuildContext context, var pillId, var takeYn, var remains,
      var totalCount) async {
    String accessToken = context.read<UserStore>().accessToken;
    const String registInvenUrl = "${CONVERT_URL}/api/v1/pill/inventory";

    try {
      bool takeYnValue = takeYn ?? false;

      var response = await http.post(Uri.parse(registInvenUrl),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': accessToken,
          },
          body: json.encode({
            'pillId': pillId,
            'takeYn': takeYnValue,
            'remains': remains,
            'totalCount': totalCount,
            'takeWeekdays': ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"],
          }));

      if (response.statusCode == 200) {
        print("재고 등록 post 수신 성공");
        print(response.body);
      } else {
        print(response.body);
        print("재고 등록 post 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
