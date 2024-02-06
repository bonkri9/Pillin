import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../component/common/app_bar.dart';
import '../../component/common/base_container.dart';
import '../../const/colors.dart';

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
      'routine' : [],
      'count' : '5',
    },
    {
      'pillName': '아연', // 영양제 이름
      'img': 'pill2', // 사진정보
      'company': '서양제당',
      'time': '17:00',
      'routine' :[],
      'count' : '2',
    },
    {
      'pillName': '마그네슘', // 영양제 이름
      'img': 'pill3', // 사진정보
      'company': '중동제당',
      'time': '17:00',
      'routine' :[],
      'count' : 1,
    },
    {
      'pillName': '루테인', // 영양제 이름
      'img': 'pill4', // 사진정보
      'company': '일본제당',
      'time': '1700',
      'routine' :[],
      'count' : 5,
    },
    {
      'pillName': '오메가3', // 영양제 이름
      'img': 'pill5', // 사진정보
      'company': '중국제당',
      'time': '1700',
      'routine' :[],
      'count' : 1,
    },
  ];


  Future<void> _selectTime(BuildContext context, int index) async {

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
              setState(() {
                _selectedTime = time;
                eatpill[index]['time'] = "${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}";
              });
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

    // await _selectCount(context, index);
    await _weekRoutine(context, index);
  }


  // 갯수 입력
  Future<void> _selectCount(BuildContext context, int index) async {
    final TextEditingController _controller = TextEditingController(); // 갯수를 입력받을 TextEditingController를 생성합니다.

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('몇개를 드시나요?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          content: TextField( // TextField를 추가합니다.
            controller: _controller, // TextEditingController를 연결합니다.
            keyboardType: TextInputType.number, // 키보드 타입을 숫자로 설정합니다.
          ),
          actions: <Widget>[
            TextButton(
              child: Text('등록하기'),
              onPressed: () {
                int count = int.tryParse(_controller.text) ?? 0; // 입력받은 값을 숫자로 변환합니다. 변환에 실패하면 0으로 처리합니다.
                setState(() {
                  eatpill[index]['count'] = count; // 입력받은 갯수를 저장합니다.
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 날짜입력
  Future<void> _weekRoutine(BuildContext context, int index) async {
    List<bool> selectedDays = List<bool>.filled(7, true); // 새로운 요일 리스트를 초기화합니다.

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder( // StatefulBuilder를 사용하여 AlertDialog 내부의 상태를 관리합니다.
          builder: (BuildContext context, StateSetter setDialogState) { // setState 대신 setDialogState를 사용합니다.
            return AlertDialog(
              title: Text('언제 드시나요?'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min, // 내용의 크기를 최소한으로 제한합니다.
                children: [
                  ...List<Widget>.generate(7, (int day) { // 각 요일에 대한 체크박스를 생성합니다.
                    return CheckboxListTile(
                      title: Text(['월', '화', '수', '목', '금', '토', '일'][day]),
                      value: selectedDays[day],
                      onChanged: (bool? value) {
                        setDialogState(() { // 체크박스의 상태를 변경합니다.
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
                    setState(() {
                      eatpill[index]['routine'] = selectedDays; // 선택한 요일을 저장합니다.
                    });
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
                return PillItem(eatpill[i], _selectTime, context, i); // 각 아이템을 StatefulWidget으로 만듭니다.
              },
            )


          ],
        ),
      ),
//하하
    );
  }
}

class PillItem extends StatefulWidget {
  final Map<String, dynamic> pillData;
  final Function selectTime;
  final BuildContext context;
  final int index;

  PillItem(this.pillData, this.selectTime, this.context, this.index);

  @override
  _PillItemState createState() => _PillItemState();
}

class _PillItemState extends State<PillItem> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: 500,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "assets/image/${widget.pillData['img']}.jpg",
                  width: 100,
                  height: 130,
                ),
                Column(
                  children: [
                    Text(
                      '${widget.pillData['company']}',
                      style: TextStyle(
                          color: BASIC_GREY,
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                    ), // 제조사
                    Text(
                      '${widget.pillData['pillName']}',
                      style: TextStyle(
                          color: BASIC_BLACK, fontWeight: FontWeight.w600),
                    ),
                  ],
                ), // 영양제명
                SizedBox(width: 100,),
                IconButton(
                  onPressed: () => widget.selectTime(widget.context, widget.index),
                  icon: Icon(Icons.add, color: BASIC_BLACK),
                ),
              ],
            ),
            if (widget.pillData['routine'].isNotEmpty) // 배열이 비어있지 않을 때만 요일을 표시합니다.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                  Row(
                    children: List<Widget>.generate(7, (int day) {
                      return Text(
                        ['월', '화', '수', '목', '금', '토', '일'][day],
                        style: TextStyle(
                          color: widget.pillData['routine'][day] ? HOT_PINK : BASIC_BLACK,
                        ),
                      );
                    }).toList(),
                  ),
                SizedBox(width: 21,),
                Text(
                  '${widget.pillData['time']}',
                  style: TextStyle(
                      color: BASIC_BLACK, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 20,),
                Text('${widget.pillData['count'].toString()}정')
                ,
                // 삭제버튼
                IconButton(
                  onPressed: () {
                    setState(() { // 상태를 변경하기 위해 setState를 호출합니다.
                      widget.pillData['count'] = 0; // count를 0으로 설정합니다.
                      widget.pillData['routine'] = []; // routine을 빈 배열로 설정합니다.
                      widget.pillData['time'] = ''; // time을 빈 문자열로 설정합니다.
                    });
                  },
                  icon: Icon(Icons.delete, color: BASIC_BLACK, size: 20,),
                ),
                SizedBox(width: 20,),
              ],

            )
          ],
        ),
      ),
    );
  }
}