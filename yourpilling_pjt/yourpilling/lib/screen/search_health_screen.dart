import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
import '../component/app_bar.dart';
import '../component/base_container.dart';
import 'package:http/http.dart' as http;
import '../store/search_store.dart';
import '../store/user_store.dart';

void loadData(BuildContext context, String health) {
  context.read<SearchStore>().getSearchHealthData(context, health);
}


class SearchHealthScreen extends StatefulWidget {
  const SearchHealthScreen({super.key});

  @override
  State<SearchHealthScreen> createState() => _SearchHealthScreenState();
}

class _SearchHealthScreenState extends State<SearchHealthScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();

  _SearchHealthScreenState() {
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
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _SearchBar(
                myController: myController,
              ),
              _MiddleTab(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 컨트롤러를 정리해주는 작업입니다.
    myController.dispose();
    super.dispose();
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: '건강고민을 검색하세요',
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
                loadData(context,myController.text);
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
  _MiddleTab({super.key});

  @override
  Widget build(BuildContext context) {
    String accessToken = context.watch<UserStore>().accessToken;
    var healthList = [
      {
        'health': '치아/뼈 건강',
      },
      {
        'health': '어린이',
      },
      {
        'health': '여성 건강',
      },
      {
        'health': '남성 건강',
      },
      {
        'health': '위장/배뇨',
      },
      {
        'health': '피로/간',
      },
      {
        'health': '기억력 개선',
      },
      {
        'health': '눈 건강',
      },
      {
        'health': '혈압,혈당,형행',
      },
      {
        'health': '다이어트',
      },
      {
        'health': '임산부',
      },
      {
        'health': '스트레스/수면',
      },
      {
        'health': '면역/향산화',
      },
      {
        'health': '탈모',
      },
     
    ];

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: healthList.map((health) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 15,
                child: BaseContainer(
                  width: 100,
                  height: 100,
                  child: TextButton(
                    onPressed: () {
                      loadData(context,health['health']!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchListScreen(
                                  myControllerValue: health['health']!)));
                    },
                    child: Text(health['health']!),
                  ),
                ),
              ),

            ]),
          );
        }).toList(),
      ),
    );
  }
}

