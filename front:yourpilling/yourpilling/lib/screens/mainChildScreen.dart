import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainChildScreen extends StatelessWidget {
  final String routeName;

  const MainChildScreen({
    required this.routeName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch(routeName){
      case '/MainPage/a':
        return Column(
          children: [
            Text('주간달력 ')
          ],
        );
      case '/MainPage/b':
        return Column(
          children: [
            Text('검색창이랑, 달력이동, 알람설정, 분석리포트 위치'),
            ElevatedButton(
              onPressed: () {
                context.go('/alarm');
              },
              child: Text('Alarm Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/callender');
              },
              child: Text('Callender Screen'),
            ),
          ],
        );
      case '/MainPage/c':
        return Center(
          child: Text('마이페이지위치'),
        );
      default:
        return Center(
          child: Text('주간 달력이랑 먹을 영양제 체크.'),
        );
    }
  }
}