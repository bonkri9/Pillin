import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:yourpilling/screens/mainScreen.dart';

import '../screens/alarmScreen.dart';
import '../screens/loginScreen.dart';
import '../screens/mainChildScreen.dart';
import '../screens/callenderScreen.dart';
import '../screens/pillDetailScreen.dart';
import '../screens/registScreen.dart';
import '../screens/rootScreen.dart';

// 로그인이 됐는지 안됐는지
// true - login OK / false - login NO
bool authState = true;

// https://blog.codefactory.ai/ -> / -> path
// https://blog.codefactory.ai/flutter -> /flutter
// / -> home
// /basic -> basic screen
// /basic/named ->
// /named
final router = GoRouter(
  // redirect: (context, state) { // 항상 검사한다.
  //   // return string (path) -> 해당 라우트로 이동한다 (path)
  //   // return null -> 원래 이동하려던 라우트로 이동한다.
  //   if (state.location == '/login/private' && !authState) {
  //     return '/login';
  //   }
  //
  //   return '/';
  // },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return RootScreen();
      },
      routes: [
        GoRoute(
          path: 'alarm',
          builder: (context, state) {
            return AlarmScreen();
          },
        ),
        GoRoute(
          path: 'callender',
          builder: (context, state) {
            // /pop
            return CallenderScreen();
          },
        ),
        GoRoute(
          path: 'pillDetail',
          builder: (context, state) {
            // /pop
            return PillDetailScreen();
          },
        ),

        ShellRoute(
          builder: (context, state, child) {
            return MainScreen(child: child);
          },
          routes: [
            // /nested/a
            GoRoute(
              path: 'MainPage/a',
              builder: (_, state) => MainChildScreen(
                routeName: '/MainPage/a',
              ),
            ),
            // /nested/b
            GoRoute(
              path: 'MainPage/b',
              builder: (_, state) => MainChildScreen(
                routeName: '/MainPage/b',
              ),
            ),
            // /nested/c
            GoRoute(
              path: 'MainPage/c',
              builder: (_, state) => MainChildScreen(
                routeName: '/MainPage/c',
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (_, state) => LoginScreen(),
        ),
        GoRoute(
          path: 'Regist',
          builder: (_, state) => RegistScreen(),
        ),

      ],
    ),
  ],

  debugLogDiagnostics: true,
);