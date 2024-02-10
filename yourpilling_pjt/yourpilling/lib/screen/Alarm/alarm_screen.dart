import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/store/inventory_store.dart';
import '../../api/firebase_api.dart';
import '../../component/common/app_bar.dart';
import '../../component/common/base_container.dart';
import '../../const/colors.dart';
import '../../firebase_options.dart';
import '../../store/alarm_store.dart';

// 시간 등록
Future<void> _selectTime(
    BuildContext context, int id, String ownPillName) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('시간을 설정하세요'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        content: TimePickerSpinner(
          is24HourMode: true,
          normalTextStyle: TextStyle(fontSize: 24, color: BASIC_GREY),
          highlightedTextStyle: TextStyle(fontSize: 24, color: BASIC_BLACK),
          spacing: 10,
          itemHeight: 40,
          isForce2Digits: true,
          onTimeChange: (time) {
            context.read<AlarmStore>().setTime(time);
            // eatpill[index]['time'] = "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('다음으로'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  // await _selectCount(context, id,ownPillName);
  await _weekRoutine(context, id);
  await context.read<AlarmStore>().postPushAlarm(context, id, ownPillName);
  await context.read<AlarmStore>().getPushAlarm(context);
}

// 시간 수정
Future<void> _updateTime(BuildContext context, int id) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('시간을 설정하세요'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        content: TimePickerSpinner(
          is24HourMode: true,
          normalTextStyle: TextStyle(fontSize: 24, color: BASIC_GREY),
          highlightedTextStyle: TextStyle(fontSize: 24, color: BASIC_BLACK),
          spacing: 10,
          itemHeight: 40,
          isForce2Digits: true,
          onTimeChange: (time) {
            context.read<AlarmStore>().setTime(time);
            // eatpill[index]['time'] = "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('다음으로'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );

  // await _selectCount(context, id,ownPillName);
  await _weekRoutine(context, id);
  await context.read<AlarmStore>().updatePushAlarm(context, id);
  await context.read<AlarmStore>().getPushAlarm(context);
}

// 요일 입력
Future<void> _weekRoutine(BuildContext context, int index) async {
  List<bool> selectedDays = List<bool>.filled(7, true); // 새로운 요일 리스트를 초기화합니다.
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        // StatefulBuilder를 사용하여 AlertDialog 내부의 상태를 관리합니다.
        builder: (BuildContext context, StateSetter setDialogState) {
          // setState 대신 setDialogState를 사용합니다.
          return AlertDialog(
            title: Text('언제 드시나요?'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min, // 내용의 크기를 최소한으로 제한합니다.
              children: [
                ...List<Widget>.generate(7, (int day) {
                  // 각 요일에 대한 체크박스를 생성합니다.
                  return CheckboxListTile(
                    title: Text(['월', '화', '수', '목', '금', '토', '일'][day]),
                    value: selectedDays[day],
                    onChanged: (bool? value) {
                      setDialogState(() {
                        // 체크박스의 상태를 변경합니다.
                        selectedDays[day] = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('등록하기'),
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

class AlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the notifcation message and display on screen
    final message = ModalRoute.of(context)!.settings;
    // 모달 경로를 가져오고 인수를 가져옵니다. 알림을 위해. 이 메시지를 받으면

    context.read<AlarmStore>().getAlarmListData(context);
    context.read<AlarmStore>().getPushAlarm(context);
    // 먹는 영양제들의 리스트가 담겨있음 ( takeTrue로 나중에 수정)

    return Scaffold(
      appBar: MainAppBar(
        barColor: Color(0xFFF5F6F9),
      ),
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "    1일째 연속 섭취중",
              style: TextStyle(
                  color: BASIC_GREY, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Text(
              "  희태님의 영양제 루틴",
              style: TextStyle(
                  color: BASIC_BLACK,
                  fontSize: TITLE_FONT_SIZE,
                  fontWeight: FontWeight.w600),
            ),
            _List(),
          ],
        ),
      ),
//하하
    );
  }
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

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: context.read<AlarmStore>().AlarmList.length,
      itemBuilder: (BuildContext context, int idx) {
        // itemBuilder는 위젯을 반환해야함
        return BaseContainer(
          color: Colors.white,
          width: 500,
          height: 200,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        "${context.read<AlarmStore>().AlarmList[idx]['imageUrl']}",
                        width: 100,
                        height: 100,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "재고 ${context.read<AlarmStore>().AlarmList[idx]['remains']}"),
                              Text(
                                  " / ${context.read<AlarmStore>().AlarmList[idx]['totalCount']}"),
                              Text(
                                  " id는 ${context.read<AlarmStore>().AlarmList[idx]['ownPillId']}"),
                            ],
                          ),
                          Text(
                              "${context.read<AlarmStore>().AlarmList[idx]['pillName']}")
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            try {
                              await Firebase.initializeApp(
                                  options:
                                      DefaultFirebaseOptions.currentPlatform);
                              await FirebaseApi()
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
                          icon: Icon(Icons.add)),
                    ],
                  ), // 컨테이너의 윗부분
                  _Bottom(
                    idx: idx,
                    ownPillId: context.read<AlarmStore>().AlarmList[idx]
                        ['ownPillId'],
                  ),
                  //절취선

                  // 절취선 종료
                ],
              )),
        );
      },
    );
  }
}

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
                itemCount: matchedData.length,
                itemBuilder: (context, index) {
                  var data = matchedData[index];
                  return ListTile(
                    title: Row(
                      children: List<Widget>.generate(7, (int day) {
                        var days = data['days'];
                        return Text(
                          ['월', '화', '수', '목', '금', '토', '일'][day],
                          style: TextStyle(
                            color: days[day] ? HOT_PINK : BASIC_BLACK,
                          ),
                        );
                      }).toList(),
                    ),
                    subtitle: Text("${data['hour']}시 ${data['minute']}분"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            // TODO: 수정 로직을 넣어주세요.
                            _updateTime(context, data['pushId']);
                          },
                          icon: Icon(Icons.edit), // 수정 아이콘 추가
                        ),
                        IconButton(
                          onPressed: () async {
                            await context
                                .read<AlarmStore>()
                                .deletePushAlarm(context, data['pushId']);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : Container(
              child: Text("알람을 추가해주세요"),
            ); // 'pushData'가 null이거나 'matchedData'가 비어있을 때 반환할 위젯
    });
  }
}
