// 모든 Firebase 작업을 처리
/*
_firebaseMessaging: FirebaseMessaging 인스턴스를 생성합니다. 이를 통해 Firebase의 메시징 기능을 이용할 수 있습니다.
initNotifications(): 사용자로부터 푸시 알림 권한을 요청하고, FCM 토큰을 가져옵니다. 이 토큰은 앱의 고유 식별자로 사용되며, 서버가 특정 앱에 메시지를 보낼 때 필요한 정보입니다.
handleMessage(): 푸시 알림 메시지를 처리하는 함수입니다. 메시지가 null이 아닌 경우, 앱 내에서 특정 경로(/notification_screen)로 이동하게 됩니다.
initPushNotifications(): 앱이 종료된 상태에서 푸시 알림을 통해 새로 열릴 때를 처리하는 이벤트 리스너를 설정합니다.
 */

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:yourpilling/main.dart';

class FirebaseApi{
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initalize notifications
  Future<void> initNotifications() async {
    // request permission from user
    // 알람 허용 하시겠습니까??
    await _firebaseMessaging.requestPermission();

    // fetch the FCM token
    // 메세징 토큰 가져오기
    final fCMToken = await _firebaseMessaging.getToken();

    print('Token $fCMToken Token'); // 토큰값 알아내기

    // 푸시알람을 초기화하고 맨처음에 이 메서드를 시작시켜보자
    initPushNotifications();

    // 이러면 토큰을 다시 설치했기떄문에 다른 토큰이 있는것처럼 보임

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