import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
import '../component/app_bar.dart';
import '../component/base_container.dart';

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
    var healthList = [
      {
        'health': '눈건강',
      },
      {
        'health': '장건강',
      },
      {
        'health': '노화 방지',
      },
      {
        'health': '속쓰림',
      },
      {
        'health': '눈건강',
      },
      {
        'health': '혈압 개선',
      },
      {
        'health': '탈모 예방',
      },
      {
        'health': '통풍',
      },
      {
        'health': '눈건강',
      },
      {
        'health': '눈건강',
      },
      {
        'health': '장건강',
      },
      {
        'health': '노화 방지',
      },
      {
        'health': '속쓰림',
      },
      {
        'health': '눈건강',
      },
      {
        'health': '혈압 개선',
      },
      {
        'health': '탈모 예방',
      },
      {
        'health': '통풍',
      },
      {
        'health': '눈건강',
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
              Positioned(
                  top: 0,
                  right: 0,
                  child: TextButton(onPressed: () {}, child: Text('v'))),
            ]),
          );
        }).toList(),
      ),
    );
  }
}
