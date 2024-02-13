import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../api/firebase_api.dart';
import '../../const/colors.dart';
import '../../firebase_options.dart';
import '../../store/alarm_store.dart';

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // get the notifcation message and display on screen
    final message = ModalRoute.of(context)!.settings;
    // 모달 경로를 가져오고 인수를 가져옵니다. 알림을 위해. 이 메시지를 받으면

    context.read<AlarmStore>().getAlarmListData(context);
    context.read<AlarmStore>().getPushAlarm(context);
    // 먹는 영양제들의 리스트가 담겨있음 ( takeTrue로 나중에 수정)

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR.withOpacity(0.8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              constraints: BoxConstraints(
                minHeight: 320,
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
                    height: 10,
                  ),
                  Lottie.asset('assets/lottie/alarm.json',
                      width: 300, height: 180),
                  Text(
                    "잊기 직전에",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Pretendard",
                      fontSize: 20,
                      color: BASIC_BLACK.withOpacity(0.9),
                    ),
                  ),
                  Text(
                    "PUSH 알림으로 알려드려요",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Pretendard",
                      fontSize: 20,
                      color: BASIC_BLACK.withOpacity(0.9),
                    ),
                  ),
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
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "밀어서 다음 영양제",
                          style: TextStyle(
                            fontFamily: "Pretendard",
                            color: BASIC_BLACK.withOpacity(0.3),
                            // 영양이 부분의 색상을 빨간색으로 지정
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Lottie.asset('assets/lottie/right-push.json',
                            width: 30, height: 30),
                      ],
                    ),
                  ),
                  _List(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 시간 등록
Future<void> _selectTime(
    BuildContext context, int id, String ownPillName) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: SizedBox(
            width: 350,
            height: 350,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '꾸준한 섭취를 도와드릴게요',
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: BASIC_BLACK.withOpacity(0.6), // 적절한 색상으로 변경
                    ),
                  ),
                  Text(
                    '복용 시간을 설정해주세요',
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: BASIC_BLACK, // 적절한 색상으로 변경
                    ),
                  ),
                  Lottie.asset('assets/lottie/alarm.json',
                      fit: BoxFit.fill,
                      width: 250,
                      height: 250),
                ],
              ),
            ),
          ),
          content: TimePickerSpinner(
            is24HourMode: false,
            normalTextStyle: TextStyle(fontSize: 22, color: BASIC_GREY),
            highlightedTextStyle: TextStyle(fontSize: 28, color: Colors.indigoAccent),
            spacing: 10,
            itemHeight: 60,
            itemWidth: 50,
            isForce2Digits: false,
            onTimeChange: (time) {
              context.read<AlarmStore>().setTime(time);
            },
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  '다음으로',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.indigoAccent, // 적절한 색상으로 변경
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );

  await _weekRoutine(context, id);
  await context.read<AlarmStore>().postPushAlarm(context, id, ownPillName);
  await context.read<AlarmStore>().getPushAlarm(context);
}

// 시간 수정
Future<void> _updateTime(BuildContext context, int id) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: SizedBox(
            width: 350,
            height: 350,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '꾸준한 섭취를 도와드릴게요',
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: BASIC_BLACK.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    '복용 시간을 설정해주세요',
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: BASIC_BLACK,
                    ),
                  ),
                  Lottie.asset('assets/lottie/alarm.json',
                      fit: BoxFit.fill,
                      width: 250,
                      height: 250),
                ],
              ),
            ),
          ),
          content: TimePickerSpinner(
            is24HourMode: false,
            normalTextStyle: TextStyle(fontSize: 22, color: BASIC_GREY),
            highlightedTextStyle: TextStyle(fontSize: 28, color: Colors.indigoAccent),
            spacing: 10,
            itemHeight: 60,
            itemWidth: 50,
            isForce2Digits: false,
            onTimeChange: (time) {
              context.read<AlarmStore>().setTime(time);
            },
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextButton(
                child: Text(
                  '다음으로',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.indigoAccent,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );

  await _weekRoutine(context, id);
  await context.read<AlarmStore>().updatePushAlarm(context, id);
  await context.read<AlarmStore>().getPushAlarm(context);
}

// 요일 입력
Future<void> _weekRoutine(BuildContext context, int index) async {
  List<bool> selectedDays = List<bool>.filled(7, false); // 새로운 요일 리스트를 초기화합니다.
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        // StatefulBuilder를 사용하여 AlertDialog 내부의 상태를 관리합니다.
        builder: (BuildContext context, StateSetter setDialogState) {
          // setState 대신 setDialogState를 사용합니다.
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Container(
              width: 350,
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("언제 드시나요?", style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Pretendard",
                  fontSize: 14,
                      color: BASIC_BLACK.withOpacity(0.6),
                ),),
                    Text(
                      '요일을 선택해주세요',
                      style: TextStyle(
                        fontFamily: "Pretendard",
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: BASIC_BLACK,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Lottie.asset('assets/lottie/calendar.json',
                        width: 300, height: 100),
                  ],
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Container(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: List.generate(7, (int day) {
                  return CheckboxListTile(
                    title: Text(
                      ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'][day],
                      style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      color: BASIC_BLACK.withOpacity(0.9),
                    ),
                    ),
                    value: selectedDays[day],
                    activeColor: Colors.indigoAccent.withOpacity(0.8),
                    onChanged: (bool? value) {
                      setDialogState(() {
                        selectedDays[day] = value ?? true;
                      });
                    },
                  );
                }),
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.indigoAccent.withOpacity(0.7),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Text('등록하기', style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: "Pretendard",
                  fontSize: 16,
                  color: Colors.white,
                ),),
                onPressed: () {
                  context.read<AlarmStore>().setWeek(selectedDays);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    },
  );
}

class _List extends StatefulWidget {
  const _List({super.key});

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  @override
  Widget build(BuildContext context) {
    context.watch<AlarmStore>().AlarmList;
    context.watch<AlarmStore>().pushData;
    var alarmWidth = MediaQuery.of(context).size.width * 0.9;

    return Container(
      height: 600,
      child: ListView.builder(
        // physics: NeverScrollableScrollPhysics(), // ListView 스크롤 방지
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: context.read<AlarmStore>().AlarmList.length,
        itemBuilder: (context, idx) {
          // itemBuilder는 위젯을 반환해야함
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: alarmWidth,
              height: 400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // 추가 버튼
                            GestureDetector(
                              onTap: () {
                                try {
                                  Firebase.initializeApp(
                                      options: DefaultFirebaseOptions
                                          .currentPlatform);
                                  FirebaseApi()
                                      .initNotifications(context); // 알람을 초기화함
                                  _selectTime(
                                      context,
                                      context.read<AlarmStore>().AlarmList[idx]
                                          ['ownPillId'],
                                      context.read<AlarmStore>().AlarmList[idx]
                                          ['pillName']);
                                } catch (e) {
                                  // 에러 처리 부분
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("경고"),
                                        content: Text("권한을 허용하지 않으면 등록할 수 없어요"),
                                        actions: [
                                          TextButton(
                                            child: Text("닫기"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 17.0,
                                backgroundColor: Colors.indigoAccent
                                    .withOpacity(0.7), // 원의 배경색
                                child: Icon(
                                  Icons.add_alarm,
                                  color: Colors.white, // 화살표 아이콘의 색상
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.network(
                            "${context.read<AlarmStore>().AlarmList[idx]['imageUrl']}",
                            width: 120,
                            height: 120,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: SizedBox(
                              width: 150,
                              child: Text(
                                "${context.read<AlarmStore>().AlarmList[idx]['pillName']}",
                                style: TextStyle(
                                  fontFamily: "Pretendard",
                                  color: BASIC_BLACK.withOpacity(0.8),
                                  // 영양이 부분의 색상을 빨간색으로 지정
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ), // 컨테이너의 윗부분
                        ],
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      _Bottom(
                        idx: idx,
                        ownPillId: context.read<AlarmStore>().AlarmList[idx]
                            ['ownPillId'],
                      ),
                      //절취선

                      // 절취선 종료
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}

// 시간 뜨는 부분
class _Bottom extends StatefulWidget {
  final int idx;
  final int ownPillId;

  const _Bottom({super.key, required this.idx, required this.ownPillId});

  @override
  State<_Bottom> createState() => _BottomState();
}

class _BottomState extends State<_Bottom> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmStore>(builder: (context, alarmStore, child) {
      var ownPillId = widget.ownPillId;
      var pushData = context.watch<AlarmStore>().pushData;
      var matchedData = [];

      for (var i = 0; i < pushData.length; i++) {
        if (pushData[i].containsKey(ownPillId.toString())) {
          matchedData.add(pushData[i][ownPillId.toString()]);
        }
      }
      return matchedData.isNotEmpty
          ? Expanded(
              child: ListView.builder(
                // scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: matchedData.length,
                itemBuilder: (context, index) {
                  var data = matchedData[index];
                  return ListTile(
                    title: data['hour'] < 12
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "오전 ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Pretendard",
                                  fontSize: 20,
                                  color: BASIC_BLACK,
                                ),
                              ),
                              TextSpan(
                                text: "${data['hour'] == 0 ? 12 : data['hour']}:${data['minute'] < 10 ? "0${data['minute']}" : data['minute']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Pretendard",
                                  fontSize: 40,
                                  color: BASIC_BLACK,
                                ),
                              ),
                            ]),
                          )
                        : RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "오후 ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Pretendard",
                            fontSize: 20,
                            color: BASIC_BLACK,
                          ),
                        ),
                        TextSpan(
                          text: "${data['hour'] == 12 ? 12 : (data['hour'] - 12)}:${data['minute'] < 10 ? "0${data['minute']}" : data['minute']}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: "Pretendard",
                            fontSize: 40,
                            color: BASIC_BLACK,
                          ),
                        ),
                      ]),
                    ),
                    subtitle: Column(
                      children: [
                        SizedBox(height: 3,),
                        Row(
                          children: List<Widget>.generate(7, (int day) {
                            var days = data['days'];
                            return days[day]
                                ? Text(
                                    ['월', '화', '수', '목', '금', '토', '일'][day],
                                    style: TextStyle(
                                      color: days[day]
                                          ? Color(0xFFFF6F61)
                                          : BASIC_GREY,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Pretendard",
                                      fontSize: 17,
                                      letterSpacing: 6,
                                    ),
                                  )
                                : Text("");
                          }).toList(),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            // TODO: 수정 로직을 넣어주세요.
                            _updateTime(context, data['pushId']);
                          },
                          icon: Icon(
                              Icons.mode_edit_outline_outlined), // 수정 아이콘 추가
                        ),
                        IconButton(
                          onPressed: () async {
                            await context
                                .read<AlarmStore>()
                                .deletePushAlarm(context, data['pushId']);
                          },
                          icon: Icon(Icons.auto_delete_outlined),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Lottie.asset('assets/lottie/no-alarm.json',
                      width: 100, height: 120),
                  Text(
                    "아직 등록된 알림이 없어요 :)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      color: BASIC_BLACK.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ); // 'pushData'가 null이거나 'matchedData'가 비어있을 때 반환할 위젯
    });
  }
}
