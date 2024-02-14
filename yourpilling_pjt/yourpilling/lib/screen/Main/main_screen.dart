import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourpilling/component/common/app_bar.dart';
import 'package:yourpilling/component/common/base_container_noheight.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Inventory/insert_inventory.dart';
import 'package:yourpilling/screen/Search/search_screen.dart';
import 'package:yourpilling/store/main_store.dart';
import '../../store/user_store.dart';
import '../Record/record_screen.dart';
import '../Alarm/alarm_screen.dart';
import '../Inventory/inventory_screen.dart';
import '../../component/common/base_container.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<MainStore>().getWeeklyData(context);
    context.read<MainStore>().getUserInventory(context);
    context.read<MainStore>().getDailyData(context);

    var userDetail = context.read<UserStore>().UserDetail;

    void setTokenInDevice(var token) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    }

    setTokenInDevice(userDetail);

    DateTime? currentBackPressTime;
    Future<bool> onWillPop() {
      DateTime now = DateTime.now();

      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          content: Text(
            "한 번 더 누르면 앱이 종료돼요",
            textAlign: TextAlign.center,
            style: TextStyle(color: BASIC_BLACK),
          ),
          backgroundColor: Colors.yellow,
          duration: Duration(milliseconds: 1100),
        ));
        return Future.value(false);
      }

      return Future.value(true);
    }

    return Scaffold(
        backgroundColor: BACKGROUND_COLOR.withOpacity(0.8),
        appBar: MainAppBar(
          barColor: Colors.white,
        ),
        body: WillPopScope(
          onWillPop: onWillPop,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Welcome(),
                SizedBox(
                  height: 15,
                ),
                _Today(), // 오늘 먹을 영양제
                SizedBox(
                  height: 15,
                ),
                _Week(), // 주간 복용 현황
                SizedBox(
                  height: 15,
                ),
                _Stock(),
              ],
            ),
          ),
        ));
  }
}

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    const weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    var screenWidth = MediaQuery.of(context).size.width;
    var dailyData = context.watch<MainStore>().dailyData;
    var userName = context.read<UserStore>().userName;
    var denominator = context.watch<MainStore>().denominator;
    var numerator = context.watch<MainStore>().numerator;
    double firstHeight = dailyData.length == 0 ? 150.0 : 300.0;
    return Container(
      width: screenWidth,
      height: firstHeight,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
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
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 23,
            ),
            dailyData == null ||
                    dailyData.length == 0 // dailyData가 없을 때 재고 등록해야 함
                ? Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${userName}님, 영양제 먼저 등록하러 가실게요!',
                          style: TextStyle(
                            fontSize: 21,
                            color: BASIC_BLACK.withOpacity(0.27),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Pretendard',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      // 추가 버튼
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => SearchScreen(showAppBar: true,),
                              transitionsBuilder: (c, a1, a2, child) =>
                                  SlideTransition(
                                position: Tween(
                                  begin: Offset(1.0, 0.0),
                                  end: Offset(0.0, 0.0),
                                )
                                    .chain(CurveTween(curve: Curves.easeInOut))
                                    .animate(a1),
                                child: child,
                              ),
                              transitionDuration: Duration(milliseconds: 750),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.indigoAccent.withOpacity(0.8), // 원의 배경색
                          child: Icon(
                            Icons.add,
                            size: 35,
                            color: Colors.white, // 화살표 아이콘의 색상
                          ),
                        ),
                      ),
                    ],
                  )
                : denominator != numerator
                    ? // 영양제 다 안먹었을 때 몇 개 남았어요 ~ 화면
                    Column(
                        children: [
                          Lottie.asset('assets/lottie/running.json',
                              width: 120, height: 120),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$userName 회원님 ',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: BASIC_BLACK,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                                TextSpan(
                                  text: '${denominator - numerator}',
                                  style: TextStyle(
                                    color: Colors
                                        .redAccent, // 영양이 부분의 색상을 빨간색으로 지정
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                                TextSpan(
                                  text: '정 남았어요!"',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: BASIC_BLACK,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Lottie.asset('assets/lottie/rabbit.json',
                              width: 120, height: 120),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '$userName 회원님 ',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: BASIC_BLACK,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                                TextSpan(
                                  text: '이걸 다 드셔?!"',
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: BASIC_BLACK,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

            // Progress Bar
            dailyData == null || denominator == 0
                ? Container()
                : denominator != numerator
                    ? Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '섭취 완료율    ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Pretendard",
                                      color: Colors.redAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${(numerator * 100 / denominator).round()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Pretendard",
                                      color: BASIC_BLACK,
                                      fontSize: 36,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' %',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: BASIC_BLACK,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: dailyData.isEmpty
                                  ? Container()
                                  : AnimatedProgressBar(
                                      width: 340,
                                      height: 15,
                                      value: numerator / denominator,
                                      duration: const Duration(seconds: 1),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Colors.orangeAccent,
                                          Colors.redAccent,
                                        ],
                                      ),
                                      backgroundColor:
                                          BASIC_GREY.withOpacity(0.2),
                                    ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '섭취 완료율    ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Pretendard",
                                      color: Colors.greenAccent.withOpacity(1),
                                      fontSize: 15,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${(numerator * 100 / denominator).round()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Pretendard",
                                      color: BASIC_BLACK,
                                      fontSize: 36,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' %',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: BASIC_BLACK,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: dailyData.isEmpty
                                  ? Container()
                                  : AnimatedProgressBar(
                                      width: 340,
                                      height: 15,
                                      value: numerator / denominator,
                                      duration: Duration(seconds: 1),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFD2FF9B).withOpacity(0.7),
                                          Colors.greenAccent,
                                        ],
                                      ),
                                      backgroundColor:
                                          BASIC_GREY.withOpacity(0.2),
                                    ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}

class _Week extends StatefulWidget {
  const _Week({super.key});

  @override
  State<_Week> createState() => _WeekState();
}

class _WeekState extends State<_Week> {
  Color fullColor = Colors.greenAccent;
  Color overFiftyColor = Colors.lightGreenAccent;
  Color underFiftyColor = Colors.redAccent.withOpacity(0.65);
  Color fiftyColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var weekData = context.watch<MainStore>().weekData;
    DateTime now = DateTime.now();
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecordScreen())); // 캘린더 페이지 이동
        },
        child: Container(
            width: screenWidth,
            // height: 160,
            constraints: BoxConstraints(
              minHeight: 210,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
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
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          "이번 주 복용 현황이에요",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Pretendard",
                            fontSize: 20,
                            color: BASIC_BLACK,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 40,
                          child: Lottie.asset(
                              'assets/lottie/calendar_better.json',
                              fit: BoxFit.fitHeight),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: IgnorePointer(
                      ignoring: true,
                      child: TableCalendar(
                        calendarFormat: CalendarFormat.week,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        availableCalendarFormats: {
                          CalendarFormat.week: 'Week',
                        },
                        focusedDay: DateTime.now(),
                        firstDay: DateTime(2024, 1, 1),
                        lastDay: DateTime(2024, 12, 31),
                        headerVisible: false,
                        locale: 'ko-KR',
                        daysOfWeekStyle: DaysOfWeekStyle(
                            weekendStyle: TextStyle(
                              color: Color(0xFFD0D0D0),
                              fontSize: 13,
                              height: 1,
                            ),
                            weekdayStyle: TextStyle(
                              height: 1,
                              color: Color(0xFFD0D0D0),
                              fontSize: 13,
                            )),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          todayTextStyle:
                              TextStyle(color: Colors.red.withOpacity(0.8)),
                          weekendTextStyle: TextStyle(color: Colors.grey),
                          defaultTextStyle: TextStyle(color: Colors.grey),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: BASIC_GREY.withOpacity(0.2)),
                            // color: Colors.red.withOpacity(0.1),
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: BASIC_GREY.withOpacity(0.2)),
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: BASIC_GREY.withOpacity(0.2)),
                          ),
                          markersMaxCount: 1,
                        ),
                        calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, date, events) {
                          String month = date.month.toString().padLeft(2, '0');
                          String day = date.day.toString().padLeft(2, '0');
                          String paramDate = '${date.year}-$month-$day';
                          print("파람 데이터 $paramDate");
                          // 현재 날짜에 해당하는 데이터 찾기
                          var dayData = weekData.firstWhere(
                            (data) => data['date'] == paramDate,
                            orElse: () => null,
                          );
                          print(dayData);

                          if (dayData != null) {
                            int needToTakenCountToday =
                                dayData['needToTakenCountToday'];
                            int actualTakenToday = dayData['actualTakenToday'];

                            double dayGauge =
                                actualTakenToday / needToTakenCountToday;

                            return Positioned(
                              bottom: 5,
                              child: SizedBox(
                                width: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: CircleProgressBar(
                                    strokeWidth: 2.6,
                                    foregroundColor: dayGauge == 1
                                        ? fullColor
                                        : dayGauge > 0.5
                                            ? overFiftyColor
                                            : dayGauge == 0.5
                                                ? fiftyColor
                                                : underFiftyColor,
                                    backgroundColor:
                                        BASIC_GREY.withOpacity(0.2),
                                    value: dayGauge, // dayGauge
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Positioned(
                              bottom: 5,
                              child: SizedBox(
                                width: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 1),
                                  child: CircleProgressBar(
                                    strokeWidth: 2.6,
                                    foregroundColor:
                                        BASIC_GREY.withOpacity(0.2),
                                    backgroundColor:
                                        BASIC_GREY.withOpacity(0.2),
                                    value: 0, // dayGauge
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      ),
                    )),
              ],
            )));
  }
}

class _Today extends StatefulWidget {
  const _Today({super.key});

  @override
  State<_Today> createState() => _TodayState();
}

class _TodayState extends State<_Today> {
  // Progress Bar 진행도
  Color btnColor = Colors.redAccent; // 버튼 색상 state
  Color beforeTakeColor = Color(0xFFFF6F61).withOpacity(0.04);
  Color afterTakeColor = Color(0xFFD2FF9B).withOpacity(0.1);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth;
    var mainStore = context.watch<MainStore>();
    var dailyData = mainStore.dailyData;
    var numerator = mainStore.numerator;

    return Container(
        width: containerWidth,
        constraints: BoxConstraints(
          minHeight: 250,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(36),
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "오늘 꼭 챙겨드세요",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: "Pretendard",
                        fontSize: 20,
                        color: BASIC_BLACK,
                      ),
                    ),
                    // Lottie.asset('assets/lottie/todo.json',
                    //     width: 40, height: 50),
                    Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => SearchScreen(showAppBar: true,),
                              transitionsBuilder: (c, a1, a2, child) =>
                                  SlideTransition(
                                position: Tween(
                                  begin: Offset(1.0, 0.0),
                                  end: Offset(0.0, 0.0),
                                )
                                    .chain(CurveTween(curve: Curves.easeInOut))
                                    .animate(a1),
                                child: child,
                              ),
                              transitionDuration: Duration(milliseconds: 750),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 13.0,
                          backgroundColor: Colors.yellow, // 원의 배경색
                          child: Icon(
                            Icons.add,
                            color: Colors.white, // 화살표 아이콘의 색상
                          ),
                        ),
                      ),
                    ),
                    // Expanded를 사용하여 나머지 공간을 차지하도록 함
                    Expanded(child: Container()),
                    // 영양제 추가 하기
                    GestureDetector(
                      onTap: () {
                        // 로직 짜줘 희태야~!~!
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.fromLTRB(9, 5, 9, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: BASIC_GREY.withOpacity(0.2), // 원의 배경색
                        ),
                        child: Text(
                          '모두 복용',
                          style: TextStyle(
                            fontFamily: "Pretendard",
                            color: BASIC_BLACK.withOpacity(0.4),
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 여기 패기 추가해야 할 수도
              dailyData == null || dailyData.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          Lottie.asset('assets/lottie/jump.json',
                              fit: BoxFit.fill, width: 200, height: 200),
                          Text(
                            "영양제 없으면 영양이 휴무날",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: BASIC_GREY,
                                fontFamily: "Pretendard"),
                          ),
                        ],
                      ),
                    )
                  : Container(),

              ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // ListView 스크롤 방지
                  shrinkWrap: true,
                  itemCount: dailyData != null ? dailyData.length : 0,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: GestureDetector(
                        onTap: () {
                          // 버튼 눌렀을 때 복용 체크, 복용한 영양제 개수 1 증가
                          context
                              .read<MainStore>()
                              .takePill(context, dailyData[i]['ownPillId']);
                        },
                        child: Container(
                            width: 300,
                            height: 85,
                            decoration: BoxDecoration(
                              color: (dailyData[i]['actualTakeCount'] ==
                                          dailyData[i]
                                              ['needToTakeTotalCount'] ||
                                      dailyData[i]['remains'] == 0)
                                  ? afterTakeColor
                                  : beforeTakeColor,
                              // 다 먹으면 노랑, 다 못먹으면 파랑                              // beforeTakeColor
                              //     : afterTakeColor,
                              borderRadius: BorderRadius.circular(23),
                              border: Border.all(
                                width: 0.1,
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 0, 20, 0),
                              child: Container(
                                width: 260,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 270,
                                          child: Text("${dailyData[i]['name']}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontFamily: "Pretendard",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.5,
                                                color: BASIC_BLACK,
                                              )),
                                        ),
                                        Text(
                                          dailyData[i]['remains'] <
                                                  dailyData[i]['takeCount']
                                              ? "재고 ${dailyData[i]['remains']}정 남음"
                                              : "${dailyData[i]['actualTakeCount']}/${dailyData[i]['needToTakeTotalCount']}정",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontFamily: "Pretendard",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: Colors.black38,
                                          ),
                                        )
                                      ],
                                    ),
                                    (dailyData[i]['actualTakeCount'] ==
                                                dailyData[i]
                                                    ['needToTakeTotalCount'] ||
                                            dailyData[i]['remains'] == 0)
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.greenAccent
                                                .withOpacity(0.9),
                                            size: 30, // 아이콘 크기 조절
                                          )
                                        : Icon(
                                            Icons.check_circle_outline,
                                            color: Color(0xFFFF6F61)
                                                .withOpacity(0.2),
                                            size: 30, // 아이콘 크기 조절
                                          )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}

// 내 영양제 재고
class _Stock extends StatefulWidget {
  const _Stock({super.key});

  @override
  State<_Stock> createState() => _StockState();
}

class _StockState extends State<_Stock> {
  // 현재까지 먹은 영양제의 개수
  int takenNum = 0;

// 색상 천천히 변경시켜보자 (미완)
  Color btnColor = Colors.redAccent; // 버튼 색상 state
  Color restFullColor = Colors.green; // 영양제 재고가 50% 이상일 때
  Color restWarningColor = Colors.orangeAccent; // 영양제 재고 50% 미만일 때
  Color restDangerColor = Colors.redAccent; // 영양제가 6개 미만으로 남았을 때
  Color restDegreeColor = Colors.green; // 초기 설정 색상
  String degreeMsg = ""; // 충분해요 적당해요 부족해요
  // 재고 정도에 따른 색상 반환 함수
  setColor(int rest, int total) {
    if (rest / total >= 0.5) {
      restDegreeColor = restFullColor;
      degreeMsg = '충분해요 ';
    } else if (rest / total >= 0.2) {
      restDegreeColor = restWarningColor;
      degreeMsg = '적당해요';
    } else {
      restDegreeColor = restDangerColor;
      degreeMsg = '부족해요';
    }
    return restDegreeColor;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 화면의 90%
    var userInventoryData = context.watch<MainStore>().userInventoryData;

    return Container(
        width: screenWidth,
        height: 340,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36), topRight: Radius.circular(36)),
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
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "내 영양제 재고",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Pretendard",
                      fontSize: 20,
                      color: BASIC_BLACK,
                    ),
                  ),
                  Lottie.asset('assets/lottie/car.json', width: 70, height: 60),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:
                      context.watch<MainStore>().userInventoryData.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Image.network(
                            "${userInventoryData[i]['imageUrl']}",
                            width: 130,
                            height: 95,
                          ),
                          SizedBox(height: 18),
                          Container(
                            width: 150,
                            child: Text(
                              "${userInventoryData[i]['pillName']}",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontFamily: "Pretendard",
                                color: BASIC_BLACK,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.fromLTRB(9, 5, 9, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: BASIC_GREY.withOpacity(0.1), // 원의 배경색
                            ),
                            child: Text(
                              "${userInventoryData[i]['remains']}정 / ${userInventoryData[i]['totalCount']}정",
                              // degreeMsg, // 충분 적당 부족 메시지
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Pretendard",
                                fontWeight: FontWeight.w400,
                                color: setColor(
                                    userInventoryData[i]['remains'] as int,
                                    userInventoryData[i]['totalCount'] as int),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
