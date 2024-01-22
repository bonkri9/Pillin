import 'package:yourpilling/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;
  final Color color;
  
  const ScheduleCard({super.key, required this.startTime, required this.endTime, required this.content, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: PRIMARY_COLOR,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),

      child: IntrinsicHeight( // Row에서 가장 높은 위젯만큼 제한됨
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Time(startTime: startTime, endTime: endTime),
            SizedBox(height: 16.0),
            _Content(content: content),
            SizedBox(height: 16.0),
            _Category(color: color)
          ],
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final int startTime;
  final int endTime;
  const _Time({super.key, required this.startTime, required this.endTime});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: PRIMARY_COLOR,
      fontSize: 16.0
    );


    return Column(
      children: [
        Text('${startTime.toString().padLeft(2,'0')}:00',style: textStyle,), // 이래야 08시 같은거 할 수 있ㄹ
        Text('${endTime.toString().padLeft(2,'0')}:00',style: textStyle.copyWith(
          fontSize: 10.0
        ),)
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;


  const _Content({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Text(content));
  }
}
class _Category extends StatelessWidget {
  final Color color;

  const _Category({
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16.0,
      height: 16.0,
    );
  }
}

