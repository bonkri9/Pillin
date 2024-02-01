import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_bottom_sheet/drag_zone_position.dart';
import 'package:just_bottom_sheet/just_bottom_sheet_configuration.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:just_bottom_sheet/just_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// dummy data
// 1월 29일에 먹은 영양제 목록
List<Event> taken31 = [
  Event(
      name: "비타민 D",
      actualTakenCount: 1,
      needToTakeTotalCount: 1,
      takeYn: true),
  Event(
      name: "비타민 A",
      actualTakenCount: 1,
      needToTakeTotalCount: 1,
      takeYn: true),
  Event(
      name: "루테인", actualTakenCount: 2, needToTakeTotalCount: 2, takeYn: true),
  Event(
      name: "아연", actualTakenCount: 2, needToTakeTotalCount: 4, takeYn: false),
];

// 1월 30일에 먹은 영양제 목록
List<Event> taken30 = [
  Event(
      name: "비타 500",
      actualTakenCount: 1,
      needToTakeTotalCount: 1,
      takeYn: true),
  Event(
      name: "홍삼", actualTakenCount: 2, needToTakeTotalCount: 2, takeYn: true),
  Event(
      name: "미에로 화이바", actualTakenCount: 4, needToTakeTotalCount: 4, takeYn: true),
];


// 1월 29일에 먹은 영양제 목록
List<Event> taken29 = [
  Event(
      name: "비타민 C",
      actualTakenCount: 1,
      needToTakeTotalCount: 1,
      takeYn: true),
  Event(
      name: "루테인", actualTakenCount: 1, needToTakeTotalCount: 2, takeYn: false),
  Event(
      name: "아연", actualTakenCount: 2, needToTakeTotalCount: 4, takeYn: false),
];

// 1월 28일에 먹은 영양제 목록
List<Event> taken28 = [
  Event(
      name: "비토닌", actualTakenCount: 2, needToTakeTotalCount: 2, takeYn: true),
  Event(
      name: "오메가3",
      actualTakenCount: 2,
      needToTakeTotalCount: 4,
      takeYn: false),
];

// 날짜와 해당일에 섭취한 영양제 매핑
Map<DateTime, dynamic> pillSource = {
  DateTime(2024, 1, 29): taken29,
  DateTime(2024, 1, 28): taken28,
  DateTime(2024, 1, 30): taken30,
  DateTime(2024, 1, 31): taken31,
};

// dummy data (해당일 영양제 섭취도 데이터)
class Event {
  String name;
  int actualTakenCount;
  bool takeYn;
  int needToTakeTotalCount;

  Event(
      {required this.name,
      required this.actualTakenCount,
      required this.needToTakeTotalCount,
      required this.takeYn});
}

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  DateTime selectedDay = DateTime.now();
  List<Event> pillListOfTheDay = [];
  int curMonth = DateTime.now().month; // 현재 월 state
  final scrollController = ScrollController();

  final String url = "http://10.0.2.2:8080/api/v1/pill/history/monthly";

  // 일단 토큰 여기에 저장
  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY3NTY4MjEsIm1lbWJlcklkIjo1MywidXNlcm5hbWUiOiJoYWhhaGEifQ.hRNjrv8o-ZrQG5vvRVIDLnIh-w9ppbmbZ9hscYk_u0uTmdbdy9oztjEskIIDd24ylIpWJcjDqpGelTSDt5HJ_w";


  // 데이터 서버에서 받자
  getData() async {
    DateTime now = DateTime.now();
    print('${now.year} 년 ${now.month}월');


    var response = await http.get(Uri.parse('$url?year=${now.year}&month=${now.month}'), headers: {
      'Content-Type' : 'application/json',
      'accessToken': accessToken,
    }, );

    if (response.statusCode == 200 ) {
      print("response 월간 기록 데이터 수선 성공 : $response");
    } else {
      print(response.body);
      print("월간 기록 데이터 수신 실패");
    }
  }

  getPillListOfTheDay(List<Event>? list) {
    setState(() {
      if (list != null) {
        pillListOfTheDay = list;
      } else {
        pillListOfTheDay = [];
      }

      print(pillListOfTheDay);
    });
  }

  getSelectedDay(DateTime date) {
    setState(() {
      selectedDay = date;
      print(selectedDay);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Color theDayCompleteBoxColor = Colors.greenAccent.withOpacity(0.1);
    Color theDayCompleteContentColor = Color(0xFF4CAF50);
    Color theDayUnCompleteBoxColor = Colors.redAccent.withOpacity(0.1);
    Color theDayUnCompleteContentColor = Colors.deepOrange;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red.withOpacity(0.8),
        toolbarHeight: 75,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => {Navigator.pop(context)}),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                // 월 선택
                showJustBottomSheet(
                  context: context,
                  dragZoneConfiguration: JustBottomSheetDragZoneConfiguration(
                    dragZonePosition: DragZonePosition.outside,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 4,
                        width: 30,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[100]
                            : Colors.white,
                      ),
                    ),
                  ),
                  configuration: JustBottomSheetPageConfiguration(
                    height: MediaQuery.of(context).size.height * 0.55,
                    builder: (context) {
                      return ListView.builder(
                        padding: EdgeInsets.all(20),
                        // controller: scrollController,
                        itemBuilder: (context, i) {
                          return Material(
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40)),
                              child: InkWell(
                                onTap: () {
                                  // 월 선택하면 해당 월로 이동
                                  setState(() {
                                    curMonth = i + 1;
                                    selectedDay = (curMonth != DateTime.now().month) ? DateTime(DateTime.now().year, i+1, 1) : DateTime(DateTime.now().year, curMonth, DateTime.now().day);
                                    pillListOfTheDay = []; // 초기화
                                  });
                                  Navigator.pop(context);
                                },
                                splashColor: BASIC_GREY.withOpacity(0.1),
                                child: ListTile(
                                  title: Center(
                                      child: TextButton(
                                    onPressed: null,
                                    child: Text(
                                      "${i + 1}월",
                                      style: TextStyle(
                                        color: BASIC_BLACK,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 12,
                      );
                    },
                    scrollController: scrollController,
                    closeOnScroll: true,
                    cornerRadius: 30,
                    backgroundColor: Colors.white,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 145),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "$curMonth월",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: BACKGROUND_COLOR,
          child: Column(
            children: [
              // 캘린더 외곽 패딩 설정
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(35)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Calender(
                      curMonth: curMonth,
                      getPillListOfTheDay: getPillListOfTheDay,
                      getSelectedDay: getSelectedDay),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 오늘 아직 먹지 않은 영양제
              // TodayRestPill(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 600,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 35, 25, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${selectedDay.month}월 ${selectedDay.day}일 (${DateFormat('EEEE', 'ko-KR').format(selectedDay)[0]})", // date 설정하기
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(), // 스크롤 막기
                          shrinkWrap: true,
                          itemCount: pillListOfTheDay.isNotEmpty
                              ? pillListOfTheDay.length
                              : 0,
                          itemBuilder: (context, i) {
                            bool isComplete =
                                pillListOfTheDay[i].actualTakenCount ==
                                    pillListOfTheDay[i].needToTakeTotalCount;
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isComplete
                                      ? theDayCompleteBoxColor
                                      : theDayUnCompleteBoxColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 75,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        pillListOfTheDay[i].name,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: isComplete
                                              ? theDayCompleteContentColor
                                              : theDayUnCompleteContentColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${pillListOfTheDay[i].actualTakenCount}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: isComplete
                                                  ? theDayCompleteContentColor
                                                  : theDayUnCompleteContentColor,
                                            ),
                                          ),
                                          Text(
                                            " / ${pillListOfTheDay[i].needToTakeTotalCount}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: isComplete
                                                  ? theDayCompleteContentColor
                                                  : theDayUnCompleteContentColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Calendar
class Calender extends StatefulWidget {
  Calender(
      {Key? key,
      required this.curMonth,
      required this.getPillListOfTheDay,
      required this.getSelectedDay})
      : super(key: key);
  var getPillListOfTheDay;
  var getSelectedDay;
  var curMonth;
  var _focusedDay;

  @override
  State<Calender> createState() => _CalenderState();
}

// 캘린더 class -> selectedDay, pillListOfTheDay
class _CalenderState extends State<Calender> {
  // 페이지 컨트롤러 선언
  DateTime selectedDay = DateTime.now();
  List<Event> pillListOfTheDay = [];

  @override
  void initState() {
    super.initState();
    // 외부 변수를 DateTime 객체로 변환
    widget._focusedDay = DateTime(DateTime.now().year, widget.curMonth);
    DateTime now = DateTime.now();
    // 현재 월의 마지막 날짜 계산
    int lastDayOfMonth = DateTime(now.year, widget.curMonth + 1, 0).day; // 1월 기준 31 잘 나옴

    // 맨 첫 화면에서 그날의 영양제 복용 목록 띄워주기
    Future.microtask(() {
      setState(() {
        widget.getPillListOfTheDay(pillSource[DateTime(selectedDay.year, selectedDay.month, selectedDay.day)]);
      });
    });
  }

  // day : 유저가 선택한 날짜
  // focusedDay : 현재 포커스 된 날짜
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      print("달력에서 선택한 날짜 $day"); // 여기까지 선택한 날짜 잘 받아짐

      // 부모 상태 함수로 업데이트
      widget.getSelectedDay(DateTime(day.year, day.month, day.day));
      widget.getPillListOfTheDay(
          pillSource[DateTime(day.year, day.month, day.day)]);
    });
  }

  List<Event> getEventsForDay(DateTime day) {
    print('$day ${pillSource[day]}');
    return pillSource[day] ?? [];
  }

  // 캘린더
  @override
  Widget build(BuildContext context) {
    Color fullColor = Colors.greenAccent;
    Color overFiftyColor = Colors.lightGreenAccent;
    Color underFiftyColor = Colors.redAccent.withOpacity(0.65);
    Color fiftyColor = Colors.yellow;
    double dayGauge = 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TableCalendar(
        eventLoader: (day) {
          DateTime selectedDate = DateTime(day.year, day.month, day.day);
          return getEventsForDay(selectedDate);
        },
        calendarFormat: CalendarFormat.month,
        locale: 'ko-KR',
        daysOfWeekHeight: 30,
        daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(
              color: Color(0xFFD0D0D0),
              fontSize: 13,
            ),
            weekdayStyle: TextStyle(
              color: Color(0xFFD0D0D0),
              fontSize: 13,
            )),
        headerVisible: false,
        // 헤더 월 보일지 말지
        rowHeight: 65,
        focusedDay: DateTime(2024, widget.curMonth, 1),
        firstDay: DateTime.utc(2023, 12, 1),
        lastDay: DateTime.utc(2024, 12, 31),

        // 월 설정하는 스타일 바꾸기
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          // leftChevronVisible: true, // 월 이동 불가
          // rightChevronVisible: true, // 월 이동 불가
          titleCentered: true,
          titleTextFormatter: (DateTime date, dynamic locale) {
            return '${date.month}월';
          },
        ),

        selectedDayPredicate: (day) => false,
        availableGestures: AvailableGestures.all,
        onDaySelected: _onDaySelected,
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          todayDecoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: BASIC_GREY.withOpacity(0.2), width: 4),
            // color: Colors.red.withOpacity(0.1),
          ),
          defaultDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: BASIC_GREY.withOpacity(0.2), width: 4),
          ),
          weekendDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: BASIC_GREY.withOpacity(0.2), width: 4),
          ),
          markersMaxCount: 1,
        ),
        calendarBuilders:
            CalendarBuilders(markerBuilder: (context, date, events) {
              int tmpTakenCnt = 0;
              List<Event>? tmp = pillSource[DateTime(date.year, date.month, date.day)];
              if (tmp == null || tmp.isEmpty) {
                dayGauge = 0;
              } else {
                for (int i = 0; i < tmp.length; i++) {
                  if (tmp[i].takeYn == true) tmpTakenCnt++;
                }

                dayGauge = (tmpTakenCnt / tmp.length);
              }

            return Positioned(
              bottom: 11,
              child: SizedBox(
                width: 40,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: CircleProgressBar(
                    strokeWidth: 3,
                    foregroundColor: dayGauge == 1 ? fullColor : dayGauge > 0.5 ? overFiftyColor : dayGauge == 0.5 ? fiftyColor : underFiftyColor,
                    backgroundColor: BASIC_GREY.withOpacity(0.2),
                    value: dayGauge, // dayGauge
                  ),
                ),
              ),
            );
        }),
      ),
    );
  }
}

class TodayRestPill extends StatelessWidget {
  const TodayRestPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_Today()],
    );
  }
}

// progress Bar 가져오기 위해 적용
class _Today extends StatefulWidget {
  const _Today({super.key});

  @override
  State<_Today> createState() => _TodayState();
}

class _TodayState extends State<_Today> {
  // 현재까지 먹은 영양제의 개수
  int takenNum = 0;

  // Progress Bar 진행도
  int gauge = 0;

  Color btnColor = Colors.redAccent; // 버튼 색상 state

  // 오늘 먹어야 할 영양제 리스트 (dummy data)
  var pillList = [
    {
      'pillName': '비타민 C', // 영양제 이름
      'time': '09:00', // 복용 시간
      'isTaken': false, // 복용 여부
      'total': 50,
      'rest': 49,
    },
    {
      'pillName': '아연',
      'time': '11:00',
      'isTaken': false,
      'total': 50,
      'rest': 24,
    },
    {
      'pillName': '마그네슘',
      'time': '21:00',
      'isTaken': false,
      'total': 50,
      'rest': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth; // 화면의 90%
    double progressBarWidth = screenWidth * 0.85;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          color: Colors.white,
        ),
        width: containerWidth,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Text(
                        "영양 섭취하는 당신이 챔피언",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Pretendard",
                          fontSize: 20,
                          color: BASIC_BLACK,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: takenNum != pillList.length
                      ? Text(
                          '${(takenNum * 100 / pillList.length).round()} %',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: BASIC_BLACK),
                        )
                      : Text(
                          "오늘의 영양 충전 완료 :)",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                ),
              ),

              // Progress Bar
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: pillList.length == takenNum
                    ? // 약 모두 다 먹었을 때 초록색 Progress Bar
                    AnimatedProgressBar(
                        width: 300,
                        value: takenNum / pillList.length,
                        duration: const Duration(seconds: 1),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.lightGreenAccent,
                            Colors.greenAccent,
                          ],
                        ),
                        backgroundColor: Colors.grey.withOpacity(0.2),
                      )
                    : // 약 아직 다 안먹었다면 원래 색상의 Progress Bar
                    AnimatedProgressBar(
                        width: progressBarWidth,
                        // height: 11,
                        value: takenNum / pillList.length,
                        duration: const Duration(seconds: 1),
                        gradient: const LinearGradient(
                          colors: [
                            Colors.orangeAccent,
                            Colors.redAccent,
                          ],
                        ),
                        backgroundColor: Colors.grey.withOpacity(0.2),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // ListView 스크롤 방지
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Container(
                          width: 300,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/image/${i + 1}.png',
                                  width: 17,
                                  height: 17,
                                ),
                                Text("${pillList[i]['pillName']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: BASIC_BLACK,
                                    )),
                                Text("${pillList[i]['time']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: BASIC_BLACK,
                                    )),
                                pillList[i]['isTaken'] == false
                                    ? // 복용을 아직 안한 영양제라면
                                    AnimatedContainer(
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.redAccent,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        duration: Duration(seconds: 2),
                                        child: TextButton(
                                          onPressed: () {
                                            // 버튼 눌렀을 때 복용 체크, 복용한 영양제 개수 1 증가
                                            setState(() {
                                              pillList[i]['isTaken'] = true;
                                              takenNum++;

                                              print(takenNum);
                                              if (pillList.length == takenNum) {
                                                btnColor = Colors.greenAccent;
                                              }
                                            });
                                          },
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero), // 패딩 없애줘야 함
                                          ),
                                          child: Text("복용",
                                              style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                      )
                                    : pillList.length != takenNum
                                        ? // 아직 다 먹진 않았고
                                        // 복용한 영양제라면
                                        Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              border: Border.all(
                                                color: Colors.redAccent,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets
                                                            .zero), // 패딩 없애줘야 함
                                              ),
                                              child: Text("완료",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          )
                                        : Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: btnColor,
                                              border: Border.all(
                                                color: btnColor,
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: TextButton(
                                              onPressed: () {},
                                              style: ButtonStyle(
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets
                                                            .zero), // 패딩 없애줘야 함
                                              ),
                                              child: Text("완료",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          )
                              ],
                            ),
                          )),
                    );
                  })
            ],
          ),
        ));
  }
}
