import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
import '../component/app_bar.dart';
import '../component/base_container.dart';
import 'package:http/http.dart' as http;

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
                      searchHealth();

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

// 통신추가
Future<void> searchHealth() async {
  // 반환 타입을 'Future<void>'로 변경합니다
  print("영양소 검색 요청");
  var response = await http.get(Uri.parse('http://10.0.2.2:8080/api/v1/pill/search/category?healthConcerns=1'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken' : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY3ODI2NjIsIm1lbWJlcklkIjo0NTgsInVzZXJuYW1lIjoicXFxcXEifQ.ysPdZwS5kQC12AyCcUOEegk3g2EM7YCFgUFuuNZFTiY4rhH6nCs454r_jBcBSs-Wb2X-3nuZ7twWkSlSv-Zi0g",
      } );

  if (response.statusCode == 200) {
    print('영양소 통신성공');
  } else {
    print(response.body);
    throw http.ClientException(
        '서버에서 성공 코드가 반환되지 않았습니다.'); // HTTP 응답 코드가 200이 아닐 경우 에러를 던집니다
  }
}