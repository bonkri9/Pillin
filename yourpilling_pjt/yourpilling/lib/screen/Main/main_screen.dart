import 'package:flutter/material.dart';
import 'package:yourpilling/component/common/app_bar.dart';
import 'package:yourpilling/component/common/base_container_noheight.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/store/main_store.dart';
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

  _Today today = _Today();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<MainStore>().getWeeklyData(context);
    context.read<MainStore>().getUserInventory(context);
    context.read<MainStore>().getDailyData(context);

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

class _Welcome extends StatelessWidget {
  const _Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Duration koreaOffset = Duration(hours: 9);
    DateTime koreaTime = now.add(koreaOffset);
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
          Padding(
            padding: EdgeInsets.only(left: 140),
            child: Text(
              ' ${koreaTime.month}월 ${koreaTime.day}일',
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
  Color fullColor = Colors.greenAccent;
  Color overFiftyColor = Colors.lightGreenAccent;
  Color underFiftyColor = Colors.redAccent.withOpacity(0.65);
  Color fiftyColor = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 화면의 90%

    return Container(
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
                  focusedDay: DateTime.now().add(Duration(hours: 9)),
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
                    todayTextStyle:
                    TextStyle(color: Colors.red.withOpacity(0.8)),
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
                    var weekData = context.watch<MainStore>().weekData;
                    DateTime koreaTime = date.add(Duration(hours: 9));
                    String month = koreaTime.month.toString().padLeft(2, '0');
                    String day = koreaTime.day.toString().padLeft(2, '0');

                    String paramDate = '${date.year}-$month-$day';

                    // 현재 날짜에 해당하는 데이터 찾기
                    var dayData = weekData['data'].firstWhere(
                          (data) => data['date'] == paramDate,
                      orElse: () => null,
                    );

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
                              backgroundColor: BASIC_GREY.withOpacity(0.2),
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
                              foregroundColor: BASIC_GREY.withOpacity(0.2),
                              backgroundColor: BASIC_GREY.withOpacity(0.2),
                              value: 0, // dayGauge
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ))
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
  // Progress Bar 진행도
  Color btnColor = Colors.redAccent; // 버튼 색상 state

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 화면의 90%
    // 오늘 먹을 영양제 목록 [{name, actualTakeCount, needToTakeTotalCount}]
    var dailyData = context.watch<MainStore>().dailyData;
    var curCompleteCount =
        context.watch<MainStore>().curCompleteCount; // 오늘 현재까지 복용한 영양제 개수

    return BaseContainerOnlyWidth(
        width: containerWidth,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
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

              // 여기 패기 추가해야 할 수도
              dailyData.isEmpty
                  ? Center(
                child: Text(
                  "오늘은 섭취할 영양제가 없어요 :)",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: BASIC_GREY),
                ),
              )
                  : Align(
                alignment: Alignment.centerRight,
                child: curCompleteCount != dailyData.length
                    ? Text(
                  '${(curCompleteCount * 100 / dailyData.length).round()} %',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: BASIC_BLACK),
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
              // Progress Bar
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: dailyData.isEmpty
                    ? Container()
                    : dailyData.length == curCompleteCount
                    ? // 약 모두 다 먹었을 때 초록색 Progress Bar
                AnimatedProgressBar(
                  width: 300,
                  value: curCompleteCount / dailyData.length,
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
                  value: curCompleteCount / dailyData.length,
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
                  itemCount: dailyData.length,
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
                                Container(
                                  width: 200,
                                  child: Text("${dailyData[i]['name']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: BASIC_BLACK,
                                      )),
                                ),
                                dailyData[i]['actualTakeCount'] !=
                                    dailyData[i][
                                    'needToTakeTotalCount'] // 해당 영양제 먹어야할 개수가 실제 개수보다 작다면
                                    ? Container(
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
                                  child: TextButton(
                                    onPressed: () async {
                                      print('누름');
                                      // 버튼 눌렀을 때 복용 체크, 복용한 영양제 개수 1 증가

                                      if (dailyData.length ==
                                          curCompleteCount) {
                                        btnColor = Colors.greenAccent;
                                      }
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
                                    : dailyData.length != curCompleteCount
                                    ? Container(
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
                                    onPressed: () async {
                                      print("완료버튼클릭");
                                      await context
                                          .read<MainStore>()
                                          .takePill(
                                          context,
                                          dailyData[i][
                                          'ownPillId']); // 복용 요청하기
                                    },
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
                                    color: Colors.greenAccent,
                                    border: Border.all(
                                      color: Colors.greenAccent,
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
                                    child: Text("완료찌발",
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
    var userInventoryData = context.watch<MainStore>().userInventoryData;
    return Container(
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
                  itemCount: context
                      .watch<MainStore>()
                      .userInventoryData
                      .length, // 홈 화면에는 3개까지만 보여주자 userInventoryData.length
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Image.network(
                            "${userInventoryData[i]['imageUrl']}",
                            width: 110,
                            height: 80,
                          ),
                          SizedBox(height: 6),
                          Container(
                            width: 120,
                            child: Text(
                              "${userInventoryData[i]['pillName']}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 10,
                                color: BASIC_BLACK,
                              ),
                            ),
                          ),
                          Text(
                            "${userInventoryData[i]['remains']}/${userInventoryData[i]['totalCount']}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: setColor(
                                  userInventoryData[i]['remains'] as int,
                                  userInventoryData[i]['totalCount'] as int),
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
