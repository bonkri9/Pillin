import 'package:yourpilling/component/pill_card.dart';
import 'package:yourpilling/component/today_banner.dart';
import 'package:flutter/material.dart';
import '../component/calender.dart';

class CallenderScreen extends StatefulWidget {
  const CallenderScreen({super.key});

  @override
  State<CallenderScreen> createState() => _CallenderScreenState();
}

class _CallenderScreenState extends State<CallenderScreen> {
  DateTime selectedDay = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
            children: [
              Calender(onDaySelected: onDaySelected,
                selectedDay: selectedDay,
                focusedDay: focusedDay,),
              SizedBox(height: 8.0,),
              TodayBanner(scheduleCount: 3, selectedDate: selectedDay),
              SizedBox(height: 8.0,),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    // child: ListView.builder(
                    //   itemCount: 16, // 몇개의 값들을 넣을지
                    //   // 한번에 다 렌더링 되는게 아니라
                    //   // 해당 인덱스에 도달했을때 재 재 렌더링
                    //   // 미리 100개를 그리지 않음
                    //   itemBuilder: (context, index){
                    //     print(index); // 이거 참고해서 값 할당하면 됨
                    //   return ScheduleCard(startTime: 8, endTime: 2, content: '오메가 ${index}', color: Colors.red);
                    //
                    //   },)

                    child: ListView.separated( // 이건 index 한번 더 받는건데 itemBuilder사이에 올 위젯이나 블록 넣는거
                      itemCount: 16,
                      itemBuilder: (context, index){
                        return ScheduleCard(startTime: 8, endTime: 2, content: '오메가 ${index}', color: Colors.red);

                      }, separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 16.0);
                    },)

                ),
              )
            ]

        ),
      ),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay){
    // 누른 날짜는 selectedDay라는 파라미터로 들어옴
    print(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay; // 이렇게 하면 월 페이지도 이동
    });
  }}
