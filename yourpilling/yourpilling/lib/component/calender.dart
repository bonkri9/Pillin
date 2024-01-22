import 'package:yourpilling/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatelessWidget {
  final DateTime? selectedDay; // ? 의 의미는 null이 돼도 된다.
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  const Calender({
    required this.selectedDay,

     required this.focusedDay, this.onDaySelected,
  Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      borderRadius: BorderRadius.circular(6.0),// 수가 클수록 더 깎임
      color: Colors.grey[200], // [] 연하게
    );

    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );

    return TableCalendar(
      // locale: 'ko_KR' , // 언어 변경
      // focusedDay: DateTime.now(),
      focusedDay: focusedDay,// 이렇게 해줘야 이동이 가능
        firstDay: DateTime(1800),
        lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false, // true로 해봐
        titleCentered: true, // 월년을 가운데로
        titleTextStyle: TextStyle( // 제목 스타일 지정
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
      ),

    ),
          calendarStyle: CalendarStyle(
          isTodayHighlighted: false, // 오늘 날짜의 하이라이트 여부
          defaultDecoration: defaultBoxDeco,
          weekendDecoration: defaultBoxDeco, // 주말
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
            width: 1.0,
            color: PRIMARY_COLOR,
            )
          ),
          // focusdate외의 날짜 설정
            outsideDecoration: BoxDecoration(
              shape: BoxShape.rectangle, //안해주면 이미지가 깨짐
            ),

          defaultTextStyle: defaultTextStyle, // 평일
          weekendTextStyle: defaultTextStyle, // 주말
          selectedTextStyle: defaultTextStyle.copyWith( // 선택일
            color: PRIMARY_COLOR,
          ),
        ),

        // selectedDay는 선택된 날짜
        // focusday는 달력을 보고있는 날짜
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date){
      // 화면에 보이는 모든 날짜에 대해 이 함수를 실행함

      // date == selectedDay; // 이러면 시 분 초 까지같아야함
      if(selectedDay == null){ // 선택되지 않은 날짜라고 인식시켜줌
        return false;
      }

      return date.year == selectedDay!.year && date.month == selectedDay!.month &&
        date.day == selectedDay!.day;
      // 모두 같으면 true를 return하게 해서 진하게 보이게 하는 것
      },
    );}
}
