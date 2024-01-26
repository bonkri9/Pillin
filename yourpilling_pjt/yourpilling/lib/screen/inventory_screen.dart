import 'package:flutter/material.dart';
import 'package:yourpilling/component/AngleContainer.dart';
import 'package:yourpilling/component/app_bar_search.dart';
import 'package:yourpilling/const/colors.dart';

import 'package:yourpilling/component/pilldetail/search_pill_detail.dart';

import '../component/BaseContainer.dart';
import '../component/login/login_main.dart';
import '../component/login/member_register.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: MainAppBarSearch(barColor: Colors.white),
        body: ListView(
          children: [
            AngleContainer(
                width: 300,
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                      SizedBox(
                        width: double.infinity,
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("성현",
                              style: TextStyle(
                                color: HOT_PINK,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              )),
                          Text(" 님",
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
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        height: 25,
                        child: TextButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.zero), // 버튼의 기본 패딩 없애기
                          ),
                          onPressed: () {},
                          child: Text(
                            "정보 수정",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            // 설정 관리
            AngleContainer(
                width: 300,
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "설정 관리",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('버튼이 클릭되었습니다.');
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.edit_notifications_outlined,
                                  size: 21,
                                ),
                                SizedBox(width: 8.0),
                                Text('알림 설정'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch,
                                  size: 19,
                                ),
                                SizedBox(width: 8.0),
                                Text('건강데이터 및 기기 연동'),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),

            // 고객 지원
            AngleContainer(
                width: 300,
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "고객 지원",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('버튼이 클릭되었습니다.');
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  size: 21,
                                ),
                                SizedBox(width: 8.0),
                                Text('앱 공유하기'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.comment_outlined,
                                  size: 19,
                                ),
                                SizedBox(width: 8.0),
                                Text('앱 스토어 리뷰 남기기'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print('버튼이 클릭되었습니다.');
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lock_outline_rounded,
                                  size: 21,
                                ),
                                SizedBox(width: 8.0),
                                Text('개인정보 처리 방침'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 19,
                                ),
                                SizedBox(width: 8.0),
                                Text('로그아웃'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BaseContainer(
                              width: 350,
                              height: 35,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PillDetailScreen()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("영양제 상세페이지",
                                        style: TextStyle(
                                          color: Colors.black,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            BaseContainer(
                              width: 350,
                              height: 35,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginMain()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("로그인",
                                        style: TextStyle(
                                          color: Colors.black,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            BaseContainer(
                              width: 350,
                              height: 35,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MemberRegister()));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("회원가입",
                                        style: TextStyle(
                                          color: Colors.black,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
