import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yourpilling/component/app_bar.dart';
import 'package:yourpilling/const/colors.dart';
import 'search_screen.dart';
import 'record_screen.dart';
import 'alarm_screen.dart';
import '../component/inventory/inventory_screen.dart';
import '../component/base_container.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
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

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          barColor: Color(0xFFF5F6F9),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                _Welcome(), // 성현님 환영해요
                _Week(), // 주간 복용 현황
                _Today(), // 오늘 먹을 영양제
                _Stock(), // 내 영양제 재고
              ]),
            )));
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 화면의 90%

    return BaseContainer(
      width: containerWidth,
      height: 50,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("어떤 영양제를 찾으세요?",
                style: TextStyle(
                  color: Colors.grey,
                )),
            Icon(Icons.search, color: Color(0xFFFF6666)),
          ],
        ),
      ),
    );
  }
}

class _Welcome extends StatelessWidget {
  const _Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
      child: Row(
        children: [
          Text(
            '성현님',
            style: TextStyle(
              color: BASIC_BLACK,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            ' 환영해요!',
            style: TextStyle(
              color: Color(0xFFFF6666),
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 110),
            child: Text(
              ' ${now.month}월 ${now.day}일',
              style: TextStyle(
                color: BASIC_BLACK,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
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
  DateTime _selectedDay = DateTime.now();
  Color fullColor = Colors.greenAccent;
  Color overFiftyColor = Colors.lightGreenAccent;
  Color underFiftyColor = Colors.redAccent.withOpacity(0.65);
  Color fiftyColor = Colors.yellow;
  double dayGauge = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 화면의 90%

    return BaseContainer(
        width: containerWidth,
        height: 160,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "주간 복용 현황",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Pretendard",
                      fontSize: 17.5,
                      color: BASIC_BLACK,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecordScreen()));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 17,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: TableCalendar(
                calendarFormat: CalendarFormat.week,
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: const {
                  CalendarFormat.week: 'Week',
                },
                focusedDay: DateTime(2024, 1, 31),
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2024, 12, 31),
                headerVisible: false,
                locale: 'ko-KR',
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(
                      color: Color(0xFFD0D0D0),
                      fontSize: 13,
                    ),
                    weekdayStyle: TextStyle(
                      color: Color(0xFFD0D0D0),
                      fontSize: 13,
                    )),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  todayTextStyle: TextStyle(color: Colors.red.withOpacity(0.8)),
                  weekendTextStyle: TextStyle(color: Colors.grey),
                  defaultTextStyle: TextStyle(color: Colors.grey),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: BASIC_GREY.withOpacity(0.2)),
                    // color: Colors.red.withOpacity(0.1),
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: BASIC_GREY.withOpacity(0.2)),
                  ),
                  weekendDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: BASIC_GREY.withOpacity(0.2)),
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
                    bottom: 5,
                    child: SizedBox(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 1),
                        child: CircleProgressBar(
                          strokeWidth: 2.6,
                          foregroundColor: dayGauge == 1 ? fullColor : dayGauge > 0.5 ? overFiftyColor : dayGauge == 0.5 ? fiftyColor : underFiftyColor,
                          backgroundColor: BASIC_GREY.withOpacity(0.2),
                          value: dayGauge, // dayGauge
                        ),
                      ),
                    ),
                  );
                }),
              )
            )
          ],
        ));
  }
}

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
    double containerWidth = screenWidth * 0.9; // 화면의 90%

    return BaseContainer(
        width: containerWidth,
        height: 300,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "오늘 섭취할 영양제",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Pretendard",
                      fontSize: 17.5,
                      color: BASIC_BLACK,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlarmScreen()));
                    },
                    icon: Icon(
                      Icons.add,
                      size: 25,
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
                      width: 320,
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

  // Progress Bar 진행도
  int gauge = 0;

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

// 색상 천천히 변경시켜보자 (미완)
  Color btnColor = Colors.redAccent; // 버튼 색상 state
  Color restFullColor = Colors.green; // 영양제 재고가 50% 이상일 때
  Color restWarningColor = Colors.orangeAccent; // 영양제 재고 50% 미만일 때
  Color restDangerColor = Colors.redAccent; // 영양제가 6개 미만으로 남았을 때
  Color restDegreeColor = Colors.green; // 초기 설정 색상

  // 재고 정도에 따른 색상 반환 함수
  setColor(int rest, int total) {
    if (rest >= total / 2) {
      restDegreeColor = restFullColor;
    } else if (rest <= 6) {
      restDegreeColor = restDangerColor;
    } else {
      restDegreeColor = restWarningColor;
    }
    return restDegreeColor;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 화면의 90%

    return BaseContainer(
        width: containerWidth,
        height: 250,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "내 영양제 재고",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Pretendard",
                      fontSize: 17.5,
                      color: BASIC_BLACK,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Inventory()));
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3, // 홈 화면에는 3개까지만 보여주자
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Image.asset(
                          "assets/image/비타민B.jpeg",
                          width: 110,
                          height: 80,
                        ),
                        SizedBox(height: 6),
                        Text(
                          "${pillList[i]['pillName']}",
                          style: TextStyle(
                            fontSize: 10,
                            color: BASIC_BLACK,
                          ),
                        ),
                        Text(
                          "${pillList[i]['rest']}/${pillList[i]['total']}",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: setColor(pillList[i]['rest'] as int,
                                pillList[i]['total'] as int),
                          ),
                        ),
                      ],
                    );
                  }),
            )
          ],
        ));
  }
}
