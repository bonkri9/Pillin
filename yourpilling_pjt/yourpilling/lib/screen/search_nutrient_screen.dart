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
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
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
              icon: Icon(
                Icons.search,
                color: Color(0xFFFF6666),
                size: 34,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchListScreen(
                              myControllerValue: myController.text,
                            )));
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
        'nutrient': '비타민A', // 영양제 이름
      },
      {
        'nutrient': '비타민B1', // 영양제 이름
      },
      {
        'nutrient': '비타민B2', // 영양제 이름
      },
      {
        'nutrient': '비타민B3', // 영양제 이름
      },
      {
        'nutrient': '비타민B6', // 영양제 이름
      },
      {
        'nutrient': '비타민B12', // 영양제 이름
      },
      {
        'nutrient': '비타민D', // 영양제 이름
      },
      {
        'nutrient': '비타민E', // 영양제 이름
      },
      {
        'nutrient': '비타민K', // 영양제 이름
      },
      {
        'nutrient': '칼슐', // 영양제 이름
      },
      {
        'nutrient': '칼륨', // 영양제 이름
      },
      {
        'nutrient': '마그네슘', // 영양제 이름
      },
      {
        'nutrient': '망간', // 영양제 이름
      },
      {
        'nutrient': '셀레늄', // 영양제 이름
      },
      {
        'nutrient': '엽산', // 영양제 이름
      },
      {
        'nutrient': '아미노산', // 영양제 이름
      },
      {
        'nutrient': '판토텐산', // 영양제 이름
      },
      {
        'nutrient': '비오틴', // 영양제 이름
      },
      {
        'nutrient': '철', // 영양제 이름
      },
      {
        'nutrient': '오메가3',
      },
      {
        'nutrient': '크롬', // 영양제 이름
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
                          builder: (context) => SearchListScreen(
                              myControllerValue: nutrient['nutrient']!)));
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
  var response = await http.get(
      Uri.parse(
          'http://10.0.2.2:8080/api/v1/pill/search/nutrition?nutritionName=셀레늄'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken':
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4NDQwODgsIm1lbWJlcklkIjo1NTIsInVzZXJuYW1lIjoic215YW5nMDIyMEBuYXZlci5jb20ifQ.SLeYeG6t8Vh_zLTJjewZafDEAjPN3DuJWb9tgXjEc7S-NpMkLm4AChnPJk06t1d24El1TplBBq6PvmWhhl9aew",
      });

  if (response.statusCode == 200) {
    print('영양제 영양소 통신성공');
    print(response.body);
  } else {
    print(response.body);
    throw http.ClientException(
        '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
  }
}
