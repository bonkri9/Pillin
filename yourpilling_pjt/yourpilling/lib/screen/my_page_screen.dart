
import 'package:flutter/material.dart';
import 'package:yourpilling/component/angle_container.dart';
import 'package:yourpilling/component/app_bar_search.dart';
import 'package:yourpilling/const/colors.dart';

import '../component/mypage/update_my_info.dart';
import '../component/mypage/update_my_info_before_check.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});
// todo : 상단바 위젯 스크롤 내리면 사라지고 올리면 뜨게 하기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          AngleContainer(
              width: 300,
              height : 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      SizedBox(width: 8,),
                      IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios, size: 18,)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text("성현", style: TextStyle(
                              color: HOT_PINK,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            )),
                            Text(" 님", style: TextStyle(
                              color: BASIC_BLACK,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            )),
                          ],
                        ),
                        Text("오늘도 건강하세요!", style: TextStyle(
                          color: BASIC_BLACK,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        ),
                        Container(
                          height: 25,
                          child: TextButton(
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size.zero),
                              padding: MaterialStateProperty.all(EdgeInsets.zero), // 버튼의 기본 패딩 없애기
                            ),
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateInfoBeforeCheck()));
                            },
                            child: Text("정보 수정", style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
          // 설정 관리
          AngleContainer(
              width: 300,
              height : 170,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("설정 관리", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: BASIC_BLACK,
                    ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        print('버튼이 클릭되었습니다.');
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.edit_notifications_outlined, size: 21,),
                              SizedBox(width: 8.0),
                              Text('알림 설정'),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Icon(Icons.watch, size: 19,),
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
              height :300,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("고객 지원", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: BASIC_BLACK,
                    ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        print('버튼이 클릭되었습니다.');
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.share_outlined, size: 21,),
                              SizedBox(width: 8.0),
                              Text('앱 공유하기'),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Icon(Icons.comment_outlined, size: 19,),
                              SizedBox(width: 8.0),
                              Text('앱 스토어 리뷰 남기기'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        print('버튼이 클릭되었습니다.');
                      },
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.lock_outline_rounded, size: 21,),
                              SizedBox(width: 8.0),
                              Text('개인정보 처리 방침'),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Icon(Icons.logout, size: 19,),
                              SizedBox(width: 8.0),
                              Text('로그아웃'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      )
    );
  }
}
