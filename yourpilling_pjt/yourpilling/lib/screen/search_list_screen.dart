import 'package:flutter/material.dart';
import 'package:yourpilling/component/base_container.dart';

import '../component/app_bar.dart';
import '../component/inventory/detail_inventory.dart';
import '../component/pilldetail/search_pill_detail.dart';
import '../const/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SearchListScreen extends StatefulWidget {
  final String myControllerValue;

  const SearchListScreen({super.key, required this.myControllerValue});

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  late final String searchInsert;
  final myController = TextEditingController();

  _SearchListScreenState() {
    myController.addListener(() {
      print("TextField content: ${myController.text}");
    });
  }

  @override
  void initState() {
    super.initState();
    searchInsert = widget.myControllerValue; // widget 키워드를 통해 myControllerValue에 접근합니다.
    myController.text = searchInsert;
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
              myController: myController, searchInsert: searchInsert,
            ),
            SizedBox(
              height: 20,
            ),
            // 검색 리스트들
            _SearchResult(),
          ],
        ),
      ),
    );
  }
}

// 검색바
class _SearchBar extends StatelessWidget {
  final String searchInsert;
  final TextEditingController myController;

  const _SearchBar({Key? key, required this.myController, required this.searchInsert}) : super(key: key);

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
                labelText: '검색어를 입력해주세요',
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
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchListScreen(myControllerValue: myController.text,)));
              }),
        ],
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    var pillList = [
      {
        'pillName': '비타민 C', // 영양제 이름
        'img': 'pill1', // 사진정보
        'company': '동양제당',
        'detail': '비타민 800mg \n EPA 700'
      },
      {
        'pillName': '아연', // 영양제 이름
        'img': 'pill2', // 사진정보
        'company': '서양제당',
        'detail': '아연 700mg \n EPA 700'
      },
      {
        'pillName': '마그네슘', // 영양제 이름
        'img': 'pill3', // 사진정보
        'company': '중동제당',
        'detail': '마그네슘 10mg \n EPA 700'
      },
      {
        'pillName': '루테인', // 영양제 이름
        'img': 'pill4', // 사진정보
        'company': '일본제당',
        'detail': '루테인 90mg'
      },
      {
        'pillName': '오메가3', // 영양제 이름
        'img': 'pill5', // 사진정보
        'company': '중국제당',
        'detail': '오메가3 150mg'
      },
      {
        'pillName': '순환엔', // 영양제 이름
        'img': 'pill6', // 사진정보
        'company': '한국제당',
        'detail': '간 20mg'
      },
      {
        'pillName': '센파워민', // 영양제 이름
        'img': 'pill7', // 사진정보
        'company': '농협제당',
        'detail': 'EPA 800mg'
      },
      {
        'pillName': '비타민 D', // 영양제 이름
        'img': 'pill8', // 사진정보
        'company': '국민제당',
        'detail': 'DHA 800mg'
      },
      {
        'pillName': '마그네슘', // 영양제 이름
        'img': 'pill9', // 사진정보
        'company': '신협제당',
        'detail': 'EPA 800mg \n EPA 700'
      },
      {
        'pillName': 'To-per-Day', // 영양제 이름
        'img': 'pill10', // 사진정보
        'company': '경주제당',
        'detail': '비타민 800mg \n EPA 700'
      },
    ];

    return Container(
      height: 650,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, i) {
              return BaseContainer(
                width: 500,
                height: 190,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${pillList[i]['company']}',
                                  style: TextStyle(
                                      color: BASIC_GREY,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800),
                                ),
                                Text(
                                  '${pillList[i]['pillName']}',
                                  style: TextStyle(
                                      color: BASIC_BLACK, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                textStyle: const TextStyle(fontSize: 10),
                              ),
                              onPressed: () {
                                searchDetail();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PillDetailScreen()));
                              },
                              child: const Text(
                                '상세 보기',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/image/${pillList[i]['img']}.jpg",
                            width: 100,
                            height: 130,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "${pillList[i]['detail']}",
                            style: TextStyle(
                              fontSize: 10,
                              color: BASIC_BLACK,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}


// 통신추가
Future<void> searchDetail() async {
  // 반환 타입을 'Future<void>'로 변경합니다
  print("상세정보 요청");
  var response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/pill/detail?pillId=1'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken' : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4Mzk5MTAsIm1lbWJlcklkIjo0NTIsInVzZXJuYW1lIjoicXFxIn0.6oz3NJI3jU_tKHfMh9muIois9fpFZ8nA7SxHJuR5USV3UUDheOhy5epoeezHmqbVODlaYiip2T1bD04nkjsXLg",
      });

  if (response.statusCode == 200) {
    print('검색 리스트 통신성공');
    print('통신온거'+response.body);
  } else {
    print(response.body);
    throw http.ClientException(
        '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
  }
}

// 통신추가
Future<void> searchName(url,pillName) async {
  // 반환 타입을 'Future<void>'로 변경합니다
  print("이름검색 요청");
  var response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/pill/search?pillName=비타민'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken' : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4NDY2MDMsIm1lbWJlcklkIjo0NTIsInVzZXJuYW1lIjoicXFxIn0.hHSNeA2vAsNkAa9416GEbpmCM9EdRNIErRQ-AoHPzZo8ltB57BUCusiov5zKLCyKN5ZynNsZpDg7wXOpgLCUGA",
      });

  if (response.statusCode == 200) {
    print('검색 통신성공');
    print(response.body);
    print('검색 통신성공');
  } else {
    print(response.body);
    throw http.ClientException(
        '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
  }
}