// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:yourpilling/screens/main_screen.dart';
//
// import '../screens/alarm_screen.dart';
// import '../screens/login_screen.dart';
// import '../screens/record_screen.dart';
// import '../screens/regist_screen.dart';
// import '../screens/root_screen.dart';
//
// // 로그인이 됐는지 안됐는지
// // true - login OK / false - login NO
// bool authState = true;
//
// // https://blog.codefactory.ai/ -> / -> path
// // https://blog.codefactory.ai/flutter -> /flutter
// // / -> home
// // /basic -> basic screen
// // /basic/named ->
// // /named
// final router = GoRouter(
//   // redirect: (context, state) { // 항상 검사한다.
//   //   // return string (path) -> 해당 라우트로 이동한다 (path)
//   //   // return null -> 원래 이동하려던 라우트로 이동한다.
//   //   if (state.location == '/login/private' && !authState) {
//   //     return '/login';
//   //   }
//   //
//   //   return '/';
//   // },
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) {
//         return RootScreen();
//       },
//       routes: [
//         GoRoute(
//           path: 'alarm',
//           builder: (context, state) {
//             return AlarmScreen();
//           },
//         ),
//         GoRoute(
//           path: 'callender',
//           builder: (context, state) {
//             // /pop
//             return RecordScreen();
//           },
//         ),
//
//         GoRoute(
//           path: 'login',
//           builder: (_, state) => LoginScreen(),
//         ),
//         GoRoute(
//           path: 'Regist',
//           builder: (_, state) => RegistScreen(),
//         ),
//
//       ],
//     ),
//   ],
//
//   debugLogDiagnostics: true,
// );