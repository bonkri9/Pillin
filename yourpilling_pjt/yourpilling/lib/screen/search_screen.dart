import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/app_bar.dart';
import 'package:yourpilling/component/kakao/kakao_login.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_health_screen.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
import 'package:yourpilling/screen/search_nutrient_screen.dart';
import 'package:yourpilling/component/base_container.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../store/search_store.dart';
import '../store/user_store.dart';

void loadData(BuildContext context, String name) {
  context.read<SearchStore>().getSearchNameData(context, name);
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();

  _SearchScreenState() {
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
        appBar: MainAppBar(
          barColor: Color(0xFFF5F6F9),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SearchBar(
              myController: myController,
            ),
            _MiddleTap(),
            _Ranking(),
            // 랭킹페이지
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
                labelText: '영양제명,제조사명',
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
                // 통신추가 - 희태
                try {
                 loadData(context, myController.text);
                  print('검색 통신성공');
                  // 절취선 이부분만 살리면 이전과 동일
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SearchListScreen(
                                myControllerValue: myController.text,
                              )));
                  // 절취선 종료
                }catch(error){
                  print('이름 검색 실패');
                  print(error);
                }

                // 통신끝 - 희태
              }),
        ],
      ),
    );
  }
}

// 성분 검색, 건강 검색
class _MiddleTap extends StatelessWidget {
  const _MiddleTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            BaseContainer(
              width: 170,
              height: 90,
              child: TextButton(
                onPressed: () {
                  // TextField에 입력된 텍스트를 출력합니다.
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchNutrientScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("영양소 검색",
                        style: TextStyle(
                            color: BASIC_BLACK, fontSize: TITLE_FONT_SIZE)),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            BaseContainer(
              width: 170,
              height: 90,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchHealthScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("건강 검색",
                        style: TextStyle(
                            color: BASIC_BLACK, fontSize: TITLE_FONT_SIZE)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 랭킹페이지
class _Ranking extends StatelessWidget {
  const _Ranking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: 350,
      height: 485,
      child: DefaultTabController(
        length: 3, // 탭의 수
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "영양제 랭킹",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: TITLE_FONT_SIZE,
                      color: BASIC_BLACK,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/image/crown.png",
                    width: 40,
                    height: 40,
                  )
                ],
              ),
            ),
            // header end
            TabBar(
              tabs: [
                Tab(text: '20대 추천'),
                Tab(text: '성분'),
                Tab(text: '건강 고민'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _AgeTab(),
                  _NutrientTab(),
                  _HealthTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 나이 탭
class _AgeTab extends StatefulWidget {
  const _AgeTab({super.key});

  @override
  State<_AgeTab> createState() => _AgeTabState();
}

class _AgeTabState extends State<_AgeTab> {
  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var agelist = [
      {
        'tabName': '전체', // 영양제 이름
      },
      {
        'tabName': '멀티비타민', // 영양제 이름
      },
      {
        'tabName': '일반', // 영양제 이름
      },
    ];

    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: agelist.length, // 배열의 길이로 할당해야겠네
              // 카테고리설정부분이야
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('${agelist[i]['tabName']}'),
                );
              },
            ),
          ),
          _showText
              ? Expanded(
              child: _SearchRanking(
                title: '${_index}',
              ))
              : Expanded(child: Text('선택')),
        ],
      ),
    );
  }
}

// 성분 탭
class _NutrientTab extends StatefulWidget {
  const _NutrientTab({super.key});

  @override
  State<_NutrientTab> createState() => _NutrientTabState();
}

class _NutrientTabState extends State<_NutrientTab> {
  var nutrientlist = [
    {
      'tabName': '오메가3', // 영양제 이름
    },
    {
      'tabName': '비타민B1', // 성분 이름
    },
    {
      'tabName': '아르기닌', // 영양제 이름
    },
    {
      'tabName': '비타민C', // 영양제 이름
    },
    {
      'tabName': '마그네슘', // 영양제 이름
    },
    {
      'tabName': '루테인', // 영양제 이름
    },
    {
      'tabName': '엽산', // 영양제 이름
    },
    {
      'tabName': '비타민D', // 영양제 이름
    },
  ];

  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nutrientlist.length, // 배열의 길이로 할당해야겠네
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('${nutrientlist[i]['tabName']}'),
                );
              },
            ),
          ),
          _showText
              ? Expanded(
              child: _SearchRanking(
                title: '${_index}',
              ))
              : Expanded(child: Text('선택2')),
        ],
      ),
    );
  }
}

// 건강고민 탭
class _HealthTab extends StatefulWidget {
  const _HealthTab({super.key});

  @override
  State<_HealthTab> createState() => _HealthTabState();
}

class _HealthTabState extends State<_HealthTab> {
  var healthlist = [
    {
      'tabName': '노화', // 건강 이름
    },
    {
      'tabName': '두뇌활동', // 건강 이름
    },
    {
      'tabName': '장 건강', // 건강 이름
    },
    {
      'tabName': '혈중 콜레스테롤', // 건강 이름
    },
    {
      'tabName': '눈 건강', // 건강 이름
    },
    {
      'tabName': '남성 건강', // 건강 이름
    },
    {
      'tabName': '피로감', // 건강 이름
    },
  ];

  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: healthlist.length,
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('${healthlist[i]['tabName']}'),
                );
              },
            ),
          ),
          _showText
              ? Expanded(
              child: _SearchRanking(
                title: '${_index}',
              ))
              : Expanded(child: Text('선택3')),
        ],
      ),
    );
  }
}

// 랭킹창에 출력되는 것들
class _SearchRanking extends StatelessWidget {
  final String title; // 문자열 매개변수 추가

  const _SearchRanking({Key? key, required this.title})
      : super(key: key); // 생성자에서 문자열 매개변수를 필수로 받도록 설정

  @override
  Widget build(BuildContext context) {
    // 종합비타민 눌렀을때
    var pillList = [
      {
        'pillName': '비타민 C', // 영양제 이름
        'img': 'pill1', // 사진정보
      },
      {
        'pillName': '아연', // 영양제 이름
        'img': 'pill2', // 사진정보
      },
      {
        'pillName': '마그네슘', // 영양제 이름
        'img': 'pill3', // 사진정보
      },
      {
        'pillName': '루테인', // 영양제 이름
        'img': 'pill4', // 사진정보
      },
      {
        'pillName': '오메가3', // 영양제 이름
        'img': 'pill5', // 사진정보
      },
      {
        'pillName': '순환엔', // 영양제 이름
        'img': 'pill6', // 사진정보
      },
      {
        'pillName': '센파워민', // 영양제 이름
        'img': 'pill7', // 사진정보
      },
      {
        'pillName': '비타민 D', // 영양제 이름
        'img': 'pill8', // 사진정보
      },
      {
        'pillName': '마그네슘', // 영양제 이름
        'img': 'pill9', // 사진정보
      },
      {
        'pillName': 'To-per-Day', // 영양제 이름
        'img': 'pill10', // 사진정보
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, i) {
            return Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/image/${i + 1}.png', // 랭킹번호
                  height: 30.0,
                  width: 30.0,
                ),
                Image.asset(
                  "assets/image/${pillList[i]['img']}.jpg",
                  width: 110,
                  height: 80,
                ),
                Text(
                  "${pillList[i]['pillName']}",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                  ),
                ),
              ],
            );
          }),
    );
  }
}

