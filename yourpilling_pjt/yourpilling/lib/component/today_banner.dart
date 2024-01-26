import 'package:yourpilling/const/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int scheduleCount;

  const TodayBanner({required this.scheduleCount,required this.selectedDate,
    Key? key,}) :
    super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row
          (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text('${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',style: textStyle,)
          ,Text(
              '${scheduleCount}개'
          ,style: textStyle,)],


        ),
      ),
    );
  }
}
