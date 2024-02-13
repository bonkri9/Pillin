import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/common/base_container.dart';

import '../../component/common/app_bar.dart';
import '../Inventory/detail_inventory.dart';
import 'search_pill_detail.dart';
import '../../const/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../store/search_store.dart';
import '../../store/user_store.dart';

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
    searchInsert =
        widget.myControllerValue; // widget 키워드를 통해 myControllerValue에 접근합니다.
    myController.text = searchInsert;
    myController.addListener(() {
      print("TextField content: ${myController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // 뒤로 가기 기능 추가
            Navigator.pop(context);
          },
        ),
        toolbarHeight: 70,
        title: _SearchBar(
          myController: myController,
          searchInsert: searchInsert,
        ),
      ),
      backgroundColor: BACKGROUND_COLOR,
      body: _SearchResult(),
    );
  }
}

// 검색바
class _SearchBar extends StatelessWidget {
  final String searchInsert;
  final TextEditingController myController;

  const _SearchBar(
      {Key? key, required this.myController, required this.searchInsert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.start, // 텍스트 왼쪽 정렬
                controller: myController,
                decoration: InputDecoration(
                  filled: false,
                  hintText: '성분 이름을 입력해주세요',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFFFF6F61),
                size: 34,
              ),
              onPressed: () async {
                try {
                  await context.read<SearchStore>().getSearchNameData(
                        context,
                        myController.text,
                      );
                  print('검색 통신 성공');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchListScreen(
                        myControllerValue: myController.text,
                      ),
                    ),
                  );
                } catch (error) {
                  print('이름 검색 실패');
                  falseDialog(context);
                  print(error);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResult extends StatelessWidget {
  const _SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    String accessToken = context.read<UserStore>().accessToken;
    var pillList = context.read<SearchStore>().searchData['data'];

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: pillList.length,
        itemBuilder: (context, i) {
          if (i == 0) {
            return GestureDetector(
              onTap: () {
                var pillId = pillList[i]['pillId'] ?? 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PillDetailScreen(
                          pillId: pillId,
                        )));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                      width: 0.1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x00b5b5b5).withOpacity(0.1),
                          offset: Offset(0.1, 0.1),
                          blurRadius: 3 // 그림자 위치 조정
                      ),
                    ]),
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 10, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${pillList[i]['manufacturer']}',
                              style: TextStyle(
                                color: BASIC_BLACK.withOpacity(0.3),
                                fontSize: 14,
                                fontFamily: "Pretendard",
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${pillList[i]['pillName']}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: BASIC_BLACK.withOpacity(0.8),
                                fontSize: 17,
                                fontFamily: "Pretendard",
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.network(
                            "${pillList[i]['imageUrl']}",
                            width: 120,
                            height: 130,
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          // Text(
                          //   "상세정보",
                          //   style: TextStyle(
                          //     fontSize: 10,
                          //     color: BASIC_BLACK,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                var pillId = pillList[i]['pillId'] ?? 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PillDetailScreen(
                              pillId: pillId,
                            )));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                      width: 0.1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x00b5b5b5).withOpacity(0.1),
                          offset: Offset(0.1, 0.1),
                          blurRadius: 3 // 그림자 위치 조정
                          ),
                    ]),
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 10, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${pillList[i]['manufacturer']}',
                              style: TextStyle(
                                color: BASIC_BLACK.withOpacity(0.3),
                                fontSize: 14,
                                fontFamily: "Pretendard",
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${pillList[i]['pillName']}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: BASIC_BLACK.withOpacity(0.8),
                                fontSize: 17,
                                fontFamily: "Pretendard",
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.network(
                            "${pillList[i]['imageUrl']}",
                            width: 120,
                            height: 130,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Text(
                          //   "상세정보",
                          //   style: TextStyle(
                          //     fontSize: 10,
                          //     color: BASIC_BLACK,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}

// 통신 오류
void falseDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: 200,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("검색결과가 없습니다."),
            ],
          ),
        ),
      );
    },
  );
}
