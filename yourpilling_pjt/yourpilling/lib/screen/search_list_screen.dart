import 'package:flutter/material.dart';
import 'package:yourpilling/component/base_container.dart';

import '../component/app_bar.dart';
import '../component/inventory/detail_inventory.dart';
import '../const/colors.dart';

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
