import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/common/app_bar.dart';
import 'package:yourpilling/component/kakao/kakao_login.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Search/search_health_screen.dart';
import 'package:yourpilling/screen/Search/search_list_screen.dart';
import 'package:yourpilling/screen/Search/search_nutrient_screen.dart';
import 'package:yourpilling/component/common/base_container.dart';
import 'package:yourpilling/screen/Search/search_pill_detail.dart';
import 'package:yourpilling/store/ranking_store.dart';
import 'dart:convert';
import '../../const/url.dart';
import '../../store/search_store.dart';
import '../../store/user_store.dart';
import 'package:http/http.dart' as http;

getTabData(BuildContext context) async {
  await context.read<RankingStore>().getCategoriData(context); // 카테고리 데이터 할당
  await context.read<RankingStore>().getRankingData(context); // 랭킹 데이터 받기
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
    getTabData(context);
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
              onPressed: () async {
                // 통신추가 - 희태
                try {
                  await context.read<SearchStore>().getSearchNameData(context, myController.text);
                  print('검색 통신성공');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchListScreen(
                            myControllerValue: myController.text,
                          )
                      )
                  );
                }
                catch(error) {
                  print('이름 검색 실패');
                  falseDialog(context);
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
            Container(
              width: 170,
              height: 90,
              color: BASIC_GREY,
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
            Container(
              width: 170,
              height: 90,
              color: Colors.white,
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
    return Container(
      width: 350,
      height: 485,
      color: Colors.white,
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
                Tab(text: '건강고민'),
                Tab(text: '성분'),
                Tab(text: '성별 및 나이'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _HealthTab(),
                  _NutrientTab(),
                  _AgeTab(),
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
    var agelist = context.read<RankingStore>().CategoriData[2]['midCategories']; // 복용 요청하기
// midCategoryId

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
                    context.read<RankingStore>().getShowData(agelist[i]['midCategoryId']);
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('${agelist[i]['midCategoryName']}'),
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

  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {

    var nutrientlist = context.read<RankingStore>().CategoriData[1]['midCategories']; // 복용 요청하기

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
                    context.read<RankingStore>().getShowData(nutrientlist[i]['midCategoryId']);
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('${nutrientlist[i]['midCategoryName']}'),
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


  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var HealthTapList = context.read<RankingStore>().CategoriData[0]['midCategories']; // 복용 요청하기

    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: HealthTapList.length,
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    context.read<RankingStore>().getShowData(HealthTapList[i]['midCategoryId']);
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('${HealthTapList[i]['midCategoryName']}'),
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
    var RankingList = context.watch<RankingStore>().ShowData;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: RankingList.length,
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
                Image.network(
                  "${RankingList[i]['imageUrl']}",
                  width: 110,
                  height: 80,
                ),
                Column(
                  children: [
                    Text("${RankingList[i]['manufacturer']}")
                    ,
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PillDetailScreen(pillId: RankingList[i]['pillId'],)));
                      }, child: Text("${RankingList[i]['pillName']}",
                    ),
                    ),
                  ],
                ),
              ],
            );
          }),
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
