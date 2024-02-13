import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourpilling/component/common/angle_container.dart';
import 'package:yourpilling/component/common/app_bar_search.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Login/enter_login_screen.dart';
import 'package:yourpilling/screen/Login/login_screen.dart';
import 'package:yourpilling/screen/Main/main_page_child_screen.dart';
import 'package:yourpilling/screen/Main/main_screen.dart';
import 'package:yourpilling/screen/Mypage/privacy_policy.dart';
import 'package:yourpilling/screen/Mypage/userinfo_detail_screen.dart';
import 'package:yourpilling/store/inventory_store.dart';

import '../../component/common/base_container.dart';
import '../../store/user_store.dart';
import '../AnalyzeReport/analysis_report.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

// todo : 상단바 위젯 스크롤 내리면 사라지고 올리면 뜨게 하기
  @override
  Widget build(BuildContext context) {
    var userDetailInfo = context.watch<UserStore>().UserDetail;
    return Scaffold(
        body: ListView(
          children: [
            AngleContainer(
                width: 300,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //     IconButton(
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //         icon: Icon(
                    //           Icons.arrow_back_ios,
                    //           size: 18,
                    //         )),
                    //   ],
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                  '${userDetailInfo?['name'] ?? ''}',
                                  style: TextStyle(
                                    color: HOT_PINK,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  )),
                              Text("님",
                                  style: TextStyle(
                                    color: BASIC_BLACK,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ],
                          ),
                          Text(
                            "오늘도 건강하세요!",
                            style: TextStyle(
                              color: BASIC_BLACK,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                Icon(Icons.login_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero), // 버튼의 기본 패딩 없애기
                                  ),
                                  onPressed: () async {
                                    // 회원정보 수정 페이지로 넘어가기
                                    await context
                                        .read<UserStore>()
                                        .getUserDetailData(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserInfoDetailScreen()));
                                  },
                                  child: Text(
                                    "내 정보 확인",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                Icon(Icons.analytics_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero), // 버튼의 기본 패딩 없애기
                                  ),
                                  onPressed: () async {
                                    // 분석리포트 페이지로 넘어가기
                                    await context
                                        .read<UserStore>()
                                        .getUserDetailData(context);
                                    context.read<InventoryStore>().getTakeYnListData(context);
                                    context.read<InventoryStore>().takeTrueListData;
                                    context.read<UserStore>().UserDetail;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AnalysisReport()));
                                  },
                                  child: Text(
                                    "내 분석리포트",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              children: [
                                Icon(Icons.lock_rounded),
                                SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero), // 버튼의 기본 패딩 없애기
                                  ),
                                  onPressed: () {
                                    // 회원정보 수정 페이지로 넘어가기
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PrivacyPolicy()));
                                  },
                                  child: Text(
                                    "개인정보처리방침",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Icon(Icons.logout_rounded),
                                TextButton(
                                  onPressed: () {
                                    showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CupertinoAlertDialog(
                                            title: const Text('알림'),
                                            content: const Text('로그아웃하시겠습니까?'),
                                            actions: <CupertinoDialogAction>[
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('아니오'),
                                              ),
                                              CupertinoDialogAction(
                                                isDestructiveAction: true,
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                                  await prefs.remove('token');
                                                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => EnterLoginScreen()),);
                                                },
                                                child: Text('예'),
                                              ),
                                            ],
                                          ),
                                    );
                                  },
                                  child: Text(
                                    '로그아웃',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            // 설정 관리
            // AngleContainer(
            //     width: 300,
            //     height: 170,
            //     child: Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "설정 관리",
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.w800,
            //               color: BASIC_BLACK,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           GestureDetector(
            //             onTap: () {
            //               print('버튼이 클릭되었습니다.');
            //             },
            //             child: Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     Icon(
            //                       Icons.edit_notifications_outlined,
            //                       size: 21,
            //                     ),
            //                     SizedBox(width: 8.0),
            //                     Text('알림 설정'),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: 20,
            //                 ),
            //                 Row(
            //                   children: [
            //                     Icon(
            //                       Icons.watch,
            //                       size: 19,
            //                     ),
            //                     SizedBox(width: 8.0),
            //                     Text('건강데이터 및 기기 연동'),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           )
            //         ],
            //       ),
            //     )),

            // 고객 지원
            // AngleContainer(
            //     width: 300,
            //     height: 300,
            //     child: Padding(
            //       padding: const EdgeInsets.all(20),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "고객 지원",
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.w800,
            //               color: BASIC_BLACK,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           GestureDetector(
            //             onTap: () {
            //               print('버튼이 클릭되었습니다.');
            //             },
            //             child: Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     Icon(
            //                       Icons.share_outlined,
            //                       size: 21,
            //                     ),
            //                     SizedBox(width: 8.0),
            //                     Text('앱 공유하기'),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: 20,
            //                 ),
            //                 Row(
            //                   children: [
            //                     Icon(
            //                       Icons.comment_outlined,
            //                       size: 19,
            //                     ),
            //                     SizedBox(width: 8.0),
            //                     Text('앱 스토어 리뷰 남기기'),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           GestureDetector(
            //             onTap: () {
            //               print('버튼이 클릭되었습니다.');
            //             },
            //             child: Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     Icon(
            //                       Icons.lock_outline_rounded,
            //                       size: 21,
            //                     ),
            //                     SizedBox(width: 8.0),
            //                     Text('개인정보 처리 방침'),
            //                   ],
            //                 ),
            //                 SizedBox(
            //                   height: 20,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     )),
          ],
        ));
  }
}
