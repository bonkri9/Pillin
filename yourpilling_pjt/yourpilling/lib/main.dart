import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/screen/Alarm/alarm_screen.dart';
import 'package:yourpilling/screen/Login/enter_login_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yourpilling/firebase_options.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:yourpilling/store/analysis_report_store.dart';
import 'package:yourpilling/store/alarm_store.dart';
import 'package:yourpilling/store/inventory_store.dart';
import 'package:yourpilling/store/main_store.dart';
import 'package:yourpilling/store/ranking_store.dart';
import 'package:yourpilling/store/record_store.dart';
import 'package:yourpilling/store/search_store.dart';
import 'package:yourpilling/store/user_store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage meesage) async {
  print("백그라운드 메히지 처리 ${meesage.notification!.body!}");
}

Future<void> initializedNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel
    (const AndroidNotificationChannel('id', '네임',importance: Importance.max));

  await flutterLocalNotificationPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher")
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}




final navigatorKey = GlobalKey<NavigatorState>(); // 키받을때 사용

void main() async {
  // 비동기선언
  // 위젯이 플러터 바인딩 보장이 초기화되었다고 말해야 이 함수를 비동기로 사용이 가능
  WidgetsFlutterBinding.ensureInitialized();
  // runApp() 충돌전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '7c21f22cbe067e3f41623266b8dab1e5',
    javaScriptAppKey: '0e507984778d791a08a9585a7a88ff5e',
  );
  Intl.defaultLocale = 'ko_KR';
  // 시간 초기화를 위해 NTP(Network Time Protocol)를 사용
  // Firebase가 앱을 초기화할때까지 기다릴 수있음
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  initializedNotification();
  // await FirebaseApi().initNotifications(); // 알람을 초기화함
  initializeDateFormatting().then((_) => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => UserStore()),
          ChangeNotifierProvider(create: (c) => MainStore()), // AnotherStore 추가
          ChangeNotifierProvider(create: (c) => SearchStore()),
          ChangeNotifierProvider(create: (c) => InventoryStore()),// AnotherStore 추가
          ChangeNotifierProvider(create: (c) => RecordStore()),// AnotherStore 추가
          ChangeNotifierProvider(create: (c) => SearchRepository()),
          ChangeNotifierProvider(create: (c) => RankingStore()),
          ChangeNotifierProvider(create: (c) => AnalysisReportStore()),
          ChangeNotifierProvider(create: (c) => AlarmStore()),
          // 필요한 만큼 ChangeNotifierProvider를 추가하시면 됩니다.
        ],
        child: SafeArea(
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: "Pretendard",
            ),
            debugShowCheckedModeBanner: false,
            home: TokenCheck(),
            // home: Consumer<UserStore>(
            //   builder: (context, userStore, child) {
            //     if (userStore.isLoggedIn) {
            //       return MainPageChild();
            //     } else {
            //       return LoginScreen();
            //     }
            //   },
            // ),
            navigatorKey: navigatorKey,
            routes: {
              '/alarm_screen':(context) => AlarmScreen(), //AlarmScreen 앞에 const 있었음
            },
          ),
        ),
      )
  )
  );
}
