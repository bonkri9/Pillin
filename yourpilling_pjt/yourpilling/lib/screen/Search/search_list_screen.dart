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
              onPressed: () async {
                try{
                  await context.read<SearchStore>().getSearchNameData(context, myController.text);
                  print('검색 통신성공');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchListScreen(myControllerValue: myController.text,)));
                }catch(error){
                  falseDialog(context);
                }

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
    String accessToken = context.watch<UserStore>().accessToken;
    var pillList = context.read<SearchStore>().SearchData['data'];


    return Container(
      height: 650,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: pillList.length,
            itemBuilder: (context, i) {
              return BaseContainer(
                color: Colors.white,
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
                                  '${pillList[i]['manufacturer']}',
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
                                var pillId = pillList[i]['pillId'] ?? 0;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PillDetailScreen(pillId: pillId,)));
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
                          Image.network(
                            "${pillList[i]['imageUrl']}",
                            width: 100,
                            height: 130,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "상세정보",
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