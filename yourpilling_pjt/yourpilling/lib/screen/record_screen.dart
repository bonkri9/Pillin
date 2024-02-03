import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_bottom_sheet/drag_zone_position.dart';
import 'package:just_bottom_sheet/just_bottom_sheet_configuration.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';
import 'package:just_bottom_sheet/just_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:yourpilling/store/record_store.dart';
import 'dart:convert';
import '../store/user_store.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  DateTime selectedDay = DateTime.now();
  int curMonth = DateTime.now().month; // 현재 월 state
  final scrollController = ScrollController();

  // getPillListOfTheDay(list) {
  //   setState(() {
  //     if (list != null) {
  //       pillListOfTheDay = list;
  //     } else {
  //       pillListOfTheDay = [];
  //     }
  //
  //     print(pillListOfTheDay);
  //   });
  // }

  getSelectedDay(DateTime date) {
    setState(() {
      selectedDay = date;
      print(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color theDayCompleteBoxColor = Colors.greenAccent.withOpacity(0.1);
    Color theDayCompleteContentColor = Color(0xFF4CAF50);
    Color theDayUnCompleteBoxColor = Colors.redAccent.withOpacity(0.1);
    Color theDayUnCompleteContentColor = Colors.deepOrange;
    context.read<RecordStore>().getMonthlyData(context); // 페이지 들어올 때 월간 데이터 조회 요청
    var pillListOfTheDay = context.read<RecordStore>().monthlyData;
    print("필리스트 : ${pillListOfTheDay}");
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
                  configuration: JustBottomSheetPageConfiguration( // 이건 월 선택 창
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
                                    curMonth = i + 1; // 현재 월
                                    selectedDay = (curMonth != DateTime.now().month) ? DateTime(DateTime.now().year, i+1, 1) : DateTime(DateTime.now().year, curMonth, DateTime.now().day); // 현재 일
                                  });
                                  context.watch<RecordStore>().pillListOfTheDay = []; // 초기화
                                  Navigator.pop(context); // 선택창 닫기
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
                  child: Calendar( // 캘린더
                      curMonth: curMonth,
                      getSelectedDay: getSelectedDay),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 오늘 아직 먹지 않은 영양제
              Container(
                width: MediaQuery.of(context).size.width,
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
                          itemCount: pillListOfTheDay != null &&
                              pillListOfTheDay['${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}'] != null &&
                              pillListOfTheDay['${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}']['taken'] != null &&
                              pillListOfTheDay['${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}']['taken'].isNotEmpty
                              ? pillListOfTheDay['${selectedDay.year}-${selectedDay.month.toString().padLeft(2, '0')}-${selectedDay.day.toString().padLeft(2, '0')}']['taken'].length
                              : 0,
                          itemBuilder: (context, i) {
                            String tmpYear = selectedDay.year.toString();
                            String tmpMonth = selectedDay.month.toString().padLeft(2, '0');
                            String tmpDay = selectedDay.day.toString().padLeft(2, '0');
                            print('여기까진 받음 : ${pillListOfTheDay['${tmpYear}-${tmpMonth}-${tmpDay}']}');
                            bool isComplete =
                                pillListOfTheDay['${tmpYear}-${tmpMonth}-${tmpDay}']['actualTakenCountTheDay'] ==
                                    pillListOfTheDay['${tmpYear}-${tmpMonth}-${tmpDay}']['needToTakenCountTheDay'];
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
                                      Container(
                                        width: 280,
                                        child: Text(
                                          pillListOfTheDay['${tmpYear}-${tmpMonth}-${tmpDay}']['taken'][i]['name'],
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: isComplete
                                                ? theDayCompleteContentColor
                                                : theDayUnCompleteContentColor,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${pillListOfTheDay['${tmpYear}-${tmpMonth}-${tmpDay}']['taken'][i]['currentTakeCount']}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: isComplete
                                                  ? theDayCompleteContentColor
                                                  : theDayUnCompleteContentColor,
                                            ),
                                          ),
                                          Text(
                                            " / ${pillListOfTheDay['${tmpYear}-${tmpMonth}-${tmpDay}']['taken'][i]['needToTakeCount']}",
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
class Calendar extends StatefulWidget {
  Calendar(
      {Key? key,
      required this.curMonth,
      required this.getSelectedDay})
      : super(key: key);
  var getSelectedDay;
  var curMonth;

  @override
  State<Calendar> createState() => _CalenderState();
}

// 캘린더 class -> selectedDay, pillListOfTheDay
class _CalenderState extends State<Calendar> {
  // 페이지 컨트롤러 선언
  DateTime selectedDay = DateTime.now();

  // @override
  // void initState() {
  //   super.initState();
  //   // 외부 변수를 DateTime 객체로 변환
  //   widget._focusedDay = DateTime(DateTime.now().year, widget.curMonth);
  //   DateTime now = DateTime.now();
  //   // 현재 월의 마지막 날짜 계산
  //   // int lastDayOfMonth = DateTime(now.year, widget.curMonth + 1, 0).day; // 1월 기준 31 잘 나옴
  //
  //   // 맨 첫 화면에서 그날의 영양제 복용 목록 띄워주기 // 날짜 형식 정리
  //   Future.microtask(() {
  //     String tmpYear = now.year.toString();
  //     String tmpMonth = '';
  //     String tmpDay = '';
  //     tmpMonth = (now.month.toString().length == 1) ? '0${now.month}' : now.month.toString();
  //     tmpDay = (now.day.toString().length == 1) ? '0${now.day}' : now.day.toString();
  //     setState(() {
  //       widget.getPillListOfTheDay(context.read<RecordStore>().monthlyData['${tmpYear}-${tmpMonth}-${tmpDay}']['taken']);
  //     });
  //
  //   });
  // }


  // day : 유저가 선택한 날짜
  // focusedDay : 현재 포커스 된 날짜
  _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      print("달력에서 선택한 날짜 ${day.day}"); // 여기까지 선택한 날짜 잘 받아짐
      widget.getSelectedDay(DateTime(day.year, day.month, day.day)); // 현재 날짜 설정
    });
  }

  getEventsForDay(pillListOfTheDay, year, month, day) {
    String tmpYear = year.toString();
    String tmpMonth = month.toString().padLeft(2, '0');
    String tmpDay = day.toString().padLeft(2, '0');

    print('필리스트 들어옴 getEventsForDay 함수안에 $pillListOfTheDay');

    if (pillListOfTheDay == null ||
        pillListOfTheDay['$year-$tmpMonth-$tmpDay'] == null ||
        pillListOfTheDay['$year-$tmpMonth-$tmpDay']['taken'] == null) {
      return [];
    } else {
      print("와 들어왔다 ㅅㅂ ${pillListOfTheDay['$year-$tmpMonth-$tmpDay']['taken']}");
      return pillListOfTheDay['$year-$tmpMonth-$tmpDay']['taken'] ?? [];
    }
  }

  // 캘린더
  @override
  Widget build(BuildContext context) {
    Color fullColor = Colors.greenAccent;
    Color overFiftyColor = Colors.lightGreenAccent;
    Color underFiftyColor = Colors.redAccent.withOpacity(0.65);
    Color fiftyColor = Colors.yellow;
    double dayGauge = 0;
    context.read<RecordStore>().getMonthlyData(context);
    var list = context.read<RecordStore>().monthlyData;

    var monthlyData = context.read<RecordStore>().monthlyData;
    print("이거 monthly임 : ${monthlyData}");

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TableCalendar(
        eventLoader: (date) {
          return getEventsForDay(list, date.year, date.month, date.day);
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
              var tmp = context.watch<RecordStore>().monthlyData[DateTime(date.year, date.month, date.day)];
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