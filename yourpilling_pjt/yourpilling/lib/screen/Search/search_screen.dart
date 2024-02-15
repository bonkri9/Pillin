import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

getTabData(BuildContext context) async {
  await context.read<RankingStore>().getCategoriData(context); // 카테고리 데이터 할당
  await context.read<RankingStore>().getRankingData(context); // 랭킹 데이터 받기
}

class SearchScreen extends StatefulWidget {
  final bool showAppBar;
  bool isLoaded = false;

  SearchScreen({Key? key, required this.showAppBar}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState(showAppBar);
}

class _SearchScreenState extends State<SearchScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();
  final bool showAppBar;

  _SearchScreenState(this.showAppBar) {
    myController.addListener(() {
      print("TextField content: ${myController.text}");
    });
  }

  // import 'package:firebase_messaging/firebase_messaging.dart';
  // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
  var messageString = "";

  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰 $token");
  }

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails('channelId', 'channelName',
                  importance: Importance.max),
            ));
        setState(() {
          messageString = message.notification!.body!;
          print("Forground 메시지 수신 : $messageString}");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTabData(context);
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR.withOpacity(0.8),
      appBar: showAppBar
          ? AppBar(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0.0,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  // 뒤로 가기 기능 추가
                  Navigator.pop(context);
                },
              ),
              toolbarHeight: 70,
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              constraints: BoxConstraints(
                minHeight: 550,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(36),
                    bottomLeft: Radius.circular(36),
                  ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Lottie.asset('assets/lottie/jump.json',
                      width: 230, height: 200),
                  SizedBox(
                    height: 45,
                  ),
                  _SearchBar(myController: myController), // 검색창
                  SizedBox(
                    height: 25,
                  ),
                  _MiddleTap(),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: screenWidth,
              constraints: BoxConstraints(
                minHeight: 400,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "영양제 랭킹",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard",
                            fontSize: 20,
                            color: BASIC_BLACK,
                          ),
                        ),
                        Lottie.asset('assets/lottie/star.json',
                            width: 90, height: 50),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // 미복용 중인 영양제 목록
                  _Ranking(),
                ],
              ),
            ),
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
        horizontal: 25,
      ),
      child: Column(
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: BASIC_GREY.withOpacity(0.15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: myController,
                      decoration: InputDecoration(
                        hintText: '어떤 영양제를 찾으세요?',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontFamily: "Pretendard",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: IconButton(
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
                  ),
                ],
              ),
            ),
          ),
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
    var buttonWidth = MediaQuery.of(context).size.width * 0.89;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchNutrientScreen()));
            },
            child: Container(
                width: buttonWidth,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFFFF6F61).withOpacity(0.65),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    width: 0.1,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 20, 0),
                  child: Container(
                    width: 260,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("영양소로 검색할게요",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: "Pretendard",
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                )),
          ),
        ),

        // 건강 고민으로 검색
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 17, 8, 0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchHealthScreen()));
            },
            child: Container(
                width: buttonWidth,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.indigoAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    width: 0.1,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 20, 0),
                  child: Container(
                    width: 260,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("건강 고민으로 검색할게요",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: "Pretendard",
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

// 랭킹페이지
class _Ranking extends StatelessWidget {
  const _Ranking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rankWidth = MediaQuery.of(context).size.width * 0.9;
    var gender = context.read<UserStore>().gender == 'MAN' ? '남성' : '여성';
    print('gender $gender');
    var CategoriData = context.watch<RankingStore>().CategoriData;

    return Container(
      width: rankWidth,
      height: 485,
      color: Colors.white,
      child: DefaultTabController(
        length: 3, // 탭의 수
        child: Column(
          children: [
            SizedBox(
              width: 10,
            ),
            // header end
            TabBar(
              indicatorWeight: 3,
              indicatorColor: Color(0xFFFF6F61),
              // 선택된 탭의 아래에 표시되는 줄의 색상
              labelColor: Color(0xFFFF6F61),
              // 선택된 탭의 텍스트 색상
              unselectedLabelColor: Colors.grey.withOpacity(0.7),
              // 선택되지 않은 탭의 텍스트 색상
              onTap: (index) {
                // 여기에 원하는 동작을 추가하세요.
                // 예를 들면, 각 탭에 따라 다른 동작을 수행하게끔 설정할 수 있습니다.
                switch (index) {
                  case 0:
                    print('건강고민 탭 선택');
                    context.read<RankingStore>().getShowData(
                        CategoriData[0]['midCategories'][0]['midCategoryId']);
                    break;
                  case 1:
                    print('성분 탭 선택');
                    context.read<RankingStore>().getShowData(
                        CategoriData[1]['midCategories'][0]['midCategoryId']);
                    break;
                  case 2:
                    print('20대 ${gender} 탭 선택');
                    context.read<RankingStore>().getShowData(
                        CategoriData[1]['midCategories'][0]['midCategoryId']);
                    // context.read<RankingStore>().getShowData(context.read<RankingStore>().CategoriData[2]['midCategories'][0]['midCategoryId']);
                    break;
                }
              },
              tabs: [
                _StyledTab('${CategoriData[0]['bigCategoryName']}'),
                _StyledTab('${CategoriData[1]['bigCategoryName']}'),
                _StyledTab('${CategoriData[2]['bigCategoryName']}'),
              ],
            ),
            SizedBox(
              height: 8,
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

class _StyledTab extends StatelessWidget {
  final String text;

  const _StyledTab(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1), // 텍스트 주변 여백 조절
      padding: EdgeInsets.fromLTRB(2, 15, 2, 15), // 텍스트 내부 여백 조절
      decoration: BoxDecoration(
        color: Colors.white, // 탭 배경색
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

//나이 탭
class _AgeTab extends StatefulWidget {
  const _AgeTab({super.key});

  @override
  State<_AgeTab> createState() => _AgeTabState();
}

class _AgeTabState extends State<_AgeTab> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var agelist = context.read<RankingStore>().CategoriData[2]
        ['midCategories']; // 복용 요청하기

    List<Map<String, dynamic>> sortedList = List.from(agelist)
      ..sort((a, b) {
        return a['midCategoryName'].compareTo(b['midCategoryName']);
      });
    print('이게 분류된 리스트 $sortedList');
    print("정렬 출력");

    print(agelist);

    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sortedList.length,
              itemBuilder: (context, i) {
                var ageCateOneDate = sortedList[i]['midCategoryName'];
                List<String> parts = ageCateOneDate.split(',');
                String ageCate = parts.first;

                String gender =
                    parts.last.trim().toUpperCase() == 'MAN' ? '남성' : '여성';
                // print("$ageCate 왼쪽은 나잇대, 오른쪽은 성별 $gender");

                return Container(
                  padding: EdgeInsets.fromLTRB(0, 6, 10, 6),
                  child: TextButton(
                    onPressed: () {
                      print("쇼데이터 입력 아이디 ${sortedList[i]['midCategoryId']}");
                      context
                          .read<RankingStore>()
                          .getShowData(sortedList[i]['midCategoryId']);
                      setState(() {
                        _index = i;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          BASIC_GREY.withOpacity(0.2), // 연한 회색 동그라미 박스의 색상
                    ),
                    child: Text(
//                       '${sortedList[i]['midCategoryName']}',
                      '$ageCate $gender',
                      style: TextStyle(
                        fontFamily: "Pretendard",
                        color: BASIC_BLACK.withOpacity(0.65),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _SearchRanking(
            title: '${_index}',
          ),
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
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var nutrientlist =
        context.read<RankingStore>().CategoriData[1]['midCategories'];

    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: nutrientlist.length,
              itemBuilder: (context, i) {
                return Container(
                  padding: EdgeInsets.fromLTRB(0, 6, 10, 6),
                  child: TextButton(
                    onPressed: () {
                      context
                          .read<RankingStore>()
                          .getShowData(nutrientlist[i]['midCategoryId']);
                      setState(() {
                        _index = i;
                      });
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          BASIC_GREY.withOpacity(0.2), // 연한 회색 동그라미 박스의 색상
                    ),
                    child: Text(
                      '${nutrientlist[i]['midCategoryName']}',
                      style: TextStyle(
                        fontFamily: "Pretendard",
                        color: BASIC_BLACK.withOpacity(0.65),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              child: _SearchRanking(
            title: '${_index}',
          )),
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
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var HealthTapList = context.read<RankingStore>().CategoriData[0]
        ['midCategories']; // 복용 요청하기

    return Column(
      children: [
        SizedBox(
          height: 50, // 높이 설정
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: HealthTapList.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.fromLTRB(0, 6, 10, 6),
                child: TextButton(
                  onPressed: () {
                    context
                        .read<RankingStore>()
                        .getShowData(HealthTapList[i]['midCategoryId']);
                    setState(() {
                      _index = i;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                        BASIC_GREY.withOpacity(0.2), // 연한 회색 동그라미 박스의 색상
                  ),
                  child: Text(
                    '${HealthTapList[i]['midCategoryName']}',
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      color: BASIC_BLACK.withOpacity(0.65),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.43,
          child: _SearchRanking(
            title: '${_index}',
          ),
        ),
      ],
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(
                color: BASIC_GREY.withOpacity(0.4),
                thickness: 1,
                height: 0,
              );
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: RankingList.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                child: Row(
                  children: [
                    Text(
                      "${i + 1}",
                      style: TextStyle(
                        color: Color(0xFFFF6F61).withOpacity(0.9),
                        fontSize: 20,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Image.network(
                      "${RankingList[i]['imageUrl']}",
                      width: 130,
                      height: 80,
                    ),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.36,
                          child: Text(
                            "${RankingList[i]['manufacturer']}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: BASIC_BLACK.withOpacity(0.3),
                              fontSize: 13,
                              fontFamily: "Pretendard",
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PillDetailScreen(
                                          pillId: RankingList[i]['pillId'],
                                        )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.36,
                            child: Text(
                              "${RankingList[i]['pillName']}",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: BASIC_BLACK.withOpacity(0.9),
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                                fontFamily: "Pretendard",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
