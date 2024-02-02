import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InventoryStore extends ChangeNotifier {
  var takeYnListData;
  var takeTrueListData;
  var takeFalseListData;

  //복용하는 영양제 전체 리스트 데이터 가져오기
  getTakeYnListData(BuildContext context) async {
    String accessToken = context.watch<UserStore>().accessToken;
    const String takeYnListUrl = 'http://10.0.2.2:8080/api/v1/pill/inventory/list';
    try {
      var response = await http.get(Uri.parse(takeYnListUrl), headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      });

      if (response.statusCode == 200) {
        print("재고 복용 목록 수신 성공");
        print(response.body);

        // InventoryStore에 응답 저장
        takeYnListData = jsonDecode(utf8.decode(response.bodyBytes));

        print("takeYnListData: ${takeYnListData["data"]}");
      } else {
        print(response.body);
        print("재고 복용 목록 수신 실패");
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

}