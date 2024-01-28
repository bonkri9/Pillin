// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class Calender extends StatefulWidget {
//   Calender({Key? key}) : super(key: key);
//
//   @override
//   State<Calender> createState() => _CalenderState();
// }
//
// class _CalenderState extends State<Calender> {
//   DateTime today = DateTime.now();
//
//   void _onDaySelected(DateTime day, DateTime focusedDay) {
//     setState(() {
//       today = day;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TableCalendar(
//       locale: 'ko-KR',
//       focusedDay: today,
//       rowHeight: 75,
//       firstDay: DateTime.utc(2015, 1, 1),
//       lastDay: DateTime.utc(2025, 12, 12),
//       headerStyle: HeaderStyle(
//         formatButtonVisible: false,
//         titleCentered: true,
//       ),
//       selectedDayPredicate: (day) => isSameDay(day, today),
//       availableGestures: AvailableGestures.all,
//       onDaySelected: _onDaySelected,
//     );
//   }
// }
