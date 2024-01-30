import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../component/app_bar.dart';
import '../component/base_container.dart';
import '../const/colors.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {


  DateTime _selectedTime = DateTime.now();
  var eatpill = [
    {
      'pillName': '비타민 C', // 영양제 이름
      'img': 'pill1', // 사진정보
      'company': '동양제당',
      'time': '17:00',
      'routine' : []
    },
    {
      'pillName': '아연', // 영양제 이름
      'img': 'pill2', // 사진정보
      'company': '서양제당',
      'time': '17:00',
      'routine' :[],
    },
    {
      'pillName': '마그네슘', // 영양제 이름
      'img': 'pill3', // 사진정보
      'company': '중동제당',
      'time': '17:00',
      'routine' :[],
    },
    {
      'pillName': '루테인', // 영양제 이름
      'img': 'pill4', // 사진정보
      'company': '일본제당',
      'time': '1700',
      'routine' :[],
    },
    {
      'pillName': '오메가3', // 영양제 이름
      'img': 'pill5', // 사진정보
      'company': '중국제당',
      'time': '1700',
      'routine' :[],
    },
  ];


  Future<void> _selectTime(BuildContext context, int index) async {
    List<bool> selectedDays = List.filled(7, false);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('시간을 설정하세요'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: Column(
            children: <Widget>[
              TimePickerSpinner(
                is24HourMode: true,
                normalTextStyle: TextStyle(fontSize: 24, color: BASIC_GREY),
                highlightedTextStyle: TextStyle(fontSize: 24, color: BASIC_BLACK),
                spacing: 10,
                itemHeight: 40,
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    _selectedTime = time;
                    eatpill[index]['time'] = "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}";
                  });
                },
              ),
              Column(
                children: List<Widget>.generate(7, (int i) {
                  return CheckboxListTile(
                    title: Text(['월', '화', '수', '목', '금', '토', '일'][i]),
                    value: selectedDays[i],
                    onChanged: (bool? value) {
                      if (value != null) {
                        setState(() {
                          selectedDays[i] = value;
                        });
                      }
                    },
                  );
                }),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('등록하기'),
              onPressed: () {
                setState(() {
                  eatpill[index]['routine'] = selectedDays;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // get the notifcation message and display on screen
    final message = ModalRoute.of(context)!.settings;
    // 모달 경로를 가져오고 인수를 가져옵니다. 알림을 위해. 이 메시지를 받으면



    return Scaffold(
      appBar: MainAppBar(
        barColor: Color(0xFFF5F6F9),
      ),
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Selected time: ${_selectedTime.hour}:${_selectedTime.minute}',
            // ),
            // SizedBox(height: 20),
            Text("    1일째 연속 섭취중", style: TextStyle(color: BASIC_GREY , fontSize: 13 ,fontWeight: FontWeight.w600),),
            Text("  희태님의 영양제 루틴",style: TextStyle(color: BASIC_BLACK,fontSize: TITLE_FONT_SIZE, fontWeight: FontWeight.w600),),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: eatpill.length,
                itemBuilder: (context, i) {
                  return BaseContainer(
                    width: 500,
                    height: 190,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/image/${eatpill[i]['img']}.jpg",
                                width: 100,
                                height: 130,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${eatpill[i]['company']}',
                                    style: TextStyle(
                                        color: BASIC_GREY,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800),
                                  ), // 제조사
                                  Text(
                                    '${eatpill[i]['pillName']}',
                                    style: TextStyle(
                                        color: BASIC_BLACK, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ), // 영양제명
                              SizedBox(width: 100,),
                              IconButton(
                                onPressed: () => _selectTime(context, i),
                                icon: Icon(Icons.add, color: BASIC_BLACK),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${eatpill[i]['time']}',
                                style: TextStyle(
                                    color: BASIC_BLACK, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 40,),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),


          ],
        ),
      ),
//하하
    );
  }
}