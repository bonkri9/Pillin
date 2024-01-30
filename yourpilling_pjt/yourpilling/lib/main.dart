import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yourpilling/screen/alarm_screen.dart';
import 'package:yourpilling/screen/main_page_child_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yourpilling/firebase_options.dart';
import 'package:yourpilling/splash.dart';

import 'api/firebase_api.dart';

final navigatorKey = GlobalKey<NavigatorState>(); // 키받을때 사용

void main() async {
  // 비동기선언
  // 위젯이 플러터 바인딩 보장이 초기화되었다고 말해야 이 함수를 비동기로 사용이 가능
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase가 앱을 초기화할때까지 기다릴 수있음
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications(); // 알람을 초기화함

  initializeDateFormatting().then((_) => runApp(SafeArea(
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: "Pretendard",
          ),
          debugShowCheckedModeBanner: false,
          // home: MainPageChild(),
        home: Splash(),
        navigatorKey: navigatorKey,
        routes: {
          '/alarm_screen':(context) => AlarmScreen(), //AlarmScreen 앞에 const 있었음
        },
      )
    )
  )
  );
}
