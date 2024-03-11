// 모든 Firebase 작업을 처리
/*
_firebaseMessaging: FirebaseMessaging 인스턴스를 생성합니다. 이를 통해 Firebase의 메시징 기능을 이용할 수 있습니다.
initNotifications(): 사용자로부터 푸시 알림 권한을 요청하고, FCM 토큰을 가져옵니다. 이 토큰은 앱의 고유 식별자로 사용되며, 서버가 특정 앱에 메시지를 보낼 때 필요한 정보입니다.
handleMessage(): 푸시 알림 메시지를 처리하는 함수입니다. 메시지가 null이 아닌 경우, 앱 내에서 특정 경로(/notification_screen)로 이동하게 됩니다.
initPushNotifications(): 앱이 종료된 상태에서 푸시 알림을 통해 새로 열릴 때를 처리하는 이벤트 리스너를 설정합니다.
 */
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/main.dart';
import '../const/url.dart';
import '../store/user_store.dart';
import 'package:http/http.dart' as http;



class FirebaseApi{
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initalize notifications
  Future<void> initNotifications(BuildContext context) async {
    // request permission from user
    // 알람 허용 하시겠습니까??
    NotificationSettings settings = await _firebaseMessaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // User granted permission
      print("User granted permission");

      // fetch the FCM token
      final fCMToken = await _firebaseMessaging.getToken();
      print('Token: $fCMToken');

      // Initialize push notifications
      String accessToken = context.read<UserStore>().accessToken;
      const String takeYnListUrl = "${CONVERT_URL}/api/v1/push/device-token";
      try {
        var response = await http.post(Uri.parse(takeYnListUrl), headers: {
          'Content-Type': 'application/json',
          'accessToken': accessToken,
        },body: jsonEncode({
          "deviceToken" : fCMToken,
        }));
        print('response 이거임 $response');

        if (response.statusCode == 200) {
          print("디바이스 토큰 등록 완료");
        } else {
          print("디바이스 토큰 등록 실패");
          throw Exception("디바이스 토큰 등록 오류");
        }
      } catch (error) {
        print("토큰 등록 에러");
        print(error);
      }
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("들어온걸 확인했다옹");
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                    'your_channel_id', // 여기를 변경
                    'your_channel_name', // 여기를 변경
                    icon: android.smallIcon,
                    // other properties...
                  )),
              payload: message.data['item_id']);
        }
      });

      initPushNotifications();
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      // 알림 허용이 거부된 경우
      print("User declined permission");
      throw Exception("Notification permission was declined");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      // 알림 허용이 임시로 허가된 경우
      print("User granted provisional permission");
    } else {
      // 알림 허용이 결정되지 않은 경우
      print("User has not yet made a choice");
    }
  }

  // function to handle receive message
  void handleMessage(RemoteMessage? message){
    // if the message is null do nothing
    if (message == null) return;

    // 탐색할때 이름이 지정된 이 푸시를 사용하여 기본메뉴에서 정의한 경로로 이동
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  Future initPushNotifications() async {
    // handel notification if the app was terminated and new opend
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listners for when a notifications opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  }
}