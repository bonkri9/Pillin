import 'package:flutter/material.dart';
import 'package:yourpilling/component/BaseContainer.dart';

import '../component/app_bar.dart';
import '../const/colors.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.9; // 화면의 90%

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Top(),
          _PillAlarm(containerWidth: containerWidth),
          // _PillAlarm 위젯을 호출하면서 containerWidth 매개변수 전달
        ],
      ),
    );
  }
}

// 영양제 루틴 설정 글귀
class _Top extends StatelessWidget {
  const _Top({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        '영양제 루틴 설정',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
    );
  }
}

// 영양제별 알람설정 컴포넌트
class _PillAlarm extends StatefulWidget {
  final double containerWidth;

  const _PillAlarm({Key? key, required this.containerWidth});

  @override
  State<_PillAlarm> createState() => _PillAlarmState();
}

class _PillAlarmState extends State<_PillAlarm> {
  TimeOfDay? selectedTime; // 선택된 시간을 저장할 변수

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (context, i) {
        return BaseContainer(
          width: widget.containerWidth,
          height: 200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/image/비타민B.jpg",
                    width: 150,
                    height: 150,
                  ),
                  Text(
                    "비타민${i + 1}",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((pickedTime) {
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      });
                    },
                    child: Icon(Icons.add_alarm_outlined),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      minimumSize: Size(40, 40),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    selectedTime != null
                        ? '설정된 시간'
                        : '',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    selectedTime != null
                        ? selectedTime!.format(context)
                        : '',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
