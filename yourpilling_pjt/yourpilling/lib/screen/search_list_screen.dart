import 'package:flutter/material.dart';
import 'package:yourpilling/component/base_container.dart';

import '../const/colors.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({super.key});

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  final myController = TextEditingController();

  _SearchListScreenState() {
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
        backgroundColor: BACKGROUND_COLOR,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SearchBar(
              myController: myController,
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
          // IconButton(
          //   icon: Icon(Icons.arrow_back_ios_new_rounded,
          //       color: Colors.black),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // TextField 위젯을 추가합니다.
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: '검색어를 입력하세요',
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
                        builder: (context) => SearchListScreen()));
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
      height: 700,
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
