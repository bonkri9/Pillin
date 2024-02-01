import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yourpilling/component/app_bar.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
import '../component/base_container.dart';
import 'package:http/http.dart' as http;

class SearchNutrientScreen extends StatefulWidget {

  const SearchNutrientScreen({super.key});

  @override
  State<SearchNutrientScreen> createState() => _SearchNutrientScreenState();
}

class _SearchNutrientScreenState extends State<SearchNutrientScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();
  final String selectNutrient = '';

  _SearchNutrientScreenState() {
    myController.addListener(() {
      print("TextField content: ${myController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 터치하면 키보드꺼짐
      },
      child: Scaffold(
        appBar: MainAppBar(
          barColor: Color(0xFFF5F6F9),
        ),
        backgroundColor: BACKGROUND_COLOR,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SearchBar(
              myController: myController,
            ),
            _MiddleTab(),
          ],
        ),
      ),
    );
  }
}

// 검색바
class _SearchBar extends StatelessWidget {
  final TextEditingController myController;

  const _SearchBar({Key? key, required this.myController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: '영양소 검색',
                hoverColor: BASIC_GREY,
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.search, color: Color(0xFFFF6666),size: 34,),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchListScreen(myControllerValue: myController.text,)));
              }),
        ],
      ),
    );
  }
}


// 중간탭
class _MiddleTab extends StatelessWidget {
  const _MiddleTab({super.key});

  @override
  Widget build(BuildContext context) {
    var nutrientList = [
      {
        'nutrient': '비타민 C', // 영양제 이름
      },
      {
        'nutrient': '오메가3', // 영양제 이름
      },
      {
        'nutrient': '루테인', // 영양제 이름
      },
      {
        'nutrient': '혈당', // 영양제 이름
      },
      {
        'nutrient': '마그네슘', // 영양제 이름
      },
      {
        'nutrient': '아연', // 영양제 이름
      },
      {
        'nutrient': '녹차추출잎', // 영양제 이름
      },
      {
        'nutrient': '순환제', // 영양제 이름
      },
      {
        'nutrient': '탈모약', // 영양제 이름
      },{
        'nutrient': '비타민 C', // 영양제 이름
      },
      {
        'nutrient': '오메가3', // 영양제 이름
      },
      {
        'nutrient': '루테인', // 영양제 이름
      },
      {
        'nutrient': '혈당', // 영양제 이름
      },
      {
        'nutrient': '마그네슘', // 영양제 이름
      },
      {
        'nutrient': '아연', // 영양제 이름
      },
      {
        'nutrient': '녹차추출잎', // 영양제 이름
      },
      {
        'nutrient': '순환제', // 영양제 이름
      },
      {
        'nutrient': '탈모약', // 영양제 이름
      },
    ];

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: nutrientList.map((nutrient) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: BaseContainer(
              width: 50,
              height: 50,
              child: TextButton(
                onPressed: () {
                  searchNutrient();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchListScreen(myControllerValue: nutrient['nutrient']!)));
                },
                child: Text(nutrient['nutrient']!),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


// 통신추가
Future<void> searchNutrient() async {
  // 반환 타입을 'Future<void>'로 변경합니다
  print("영양제 영양소 검색 요청");
  var response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/pill/search/nutrition?nutritionName=셀레늄'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken' : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4MDE2MjUsIm1lbWJlcklkIjoyMTA3LCJ1c2VybmFtZSI6InE0In0.SXxlEkCTVu2QiCVEpnc6MSLG_hhEVYMc5bVafGqsVexAJtny90OJZ1ywgcAEgXOXHv7Bn06jnMWnz3QDH_o35Q",
      } );

  if (response.statusCode == 200) {
    print('영양제 영양소 통신성공');
    print(response.body);
  } else {
    print(response.body);
    throw http.ClientException(
        '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
  }
}