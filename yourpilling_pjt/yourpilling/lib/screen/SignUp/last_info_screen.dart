import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/screen/Login/login_screen.dart';
import 'package:yourpilling/screen/Main/main_page_child_screen.dart';
import 'package:yourpilling/screen/Main/main_screen.dart';
import 'package:yourpilling/screen/SignUp/greeting_screen.dart';
import 'package:yourpilling/store/user_store.dart';

import '../../const/colors.dart';

class LastInfoScreen extends StatefulWidget {
  const LastInfoScreen({super.key});

  @override
  State<LastInfoScreen> createState() => _LastInfoScreenState();
}

class _LastInfoScreenState extends State<LastInfoScreen> {
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();


  late FocusNode monthFocusNode;
  late FocusNode dayFocusNode;

  String year = '';
  String month = '';
  String day = '';

  @override
  void initState() {
    super.initState();
    monthFocusNode = FocusNode();
    dayFocusNode = FocusNode();

    // 년 입력 필드에 포커스가 왔을 때 일로 자동 이동
    yearController.addListener(() {
      if (yearController.text.length == 4) {
        FocusScope.of(context).requestFocus(monthFocusNode);
      }
    });

    // 월 입력 필드에 포커스가 왔을 때 일로 자동 이동
    monthController.addListener(() {
      if (monthController.text.length == 2) {
        FocusScope.of(context).requestFocus(dayFocusNode);
      }
    });
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    monthFocusNode.dispose();
    dayFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width * 0.9;
    var inputWidth = MediaQuery.of(context).size.width * 0.25;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset('assets/lottie/kickboard.json',
                      width: 300, height: 300),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: context.watch<UserStore>().userName,
                          style: TextStyle(
                            color: Colors.redAccent, // 영양이 부분의 색상을 빨간색으로 지정
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '님의 생일을 알려주세요.',
                          style: TextStyle(
                            fontSize: 26,
                            color: BASIC_BLACK,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "나이를 기준으로 맞춤 정보를 제공해드려요",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: inputWidth,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              color: BASIC_GREY.withOpacity(0.1),
                            ),
                            child: Center(
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.datetime,
                                autofocus: true,
                                controller: yearController,
                                onChanged: (value) {
                                  setState(() {
                                    year = value;
                                  });
                                },
                                maxLength: 4,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: "년",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onEditingComplete: () {
                                  if (yearController.text.length == 4) { // 입력값이 변경되면 다음 입력 필드로 포커스 이동
                                    FocusScope.of(context).requestFocus(monthFocusNode);
                                  }
                                },

                              ),
                            )),
                        SizedBox(
                          width: 15,
                        ),
                        // 월 입력
                        Container(
                            width: inputWidth,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              color: BASIC_GREY.withOpacity(0.1),
                            ),
                            child: Center(
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.datetime,
                                controller: monthController,
                                focusNode: monthFocusNode,
                                onChanged: (value) {
                                  setState(() {
                                    month = value;
                                  });
                                },
                                maxLength: 2,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: "월",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onEditingComplete: () {
                                  if (monthController.text.length == 4) { // 입력값이 변경되면 다음 입력 필드로 포커스 이동
                                    FocusScope.of(context).requestFocus(dayFocusNode);
                                  }
                                },
                              ),
                            )),
                        SizedBox(width: 15,),
                        // 일 입력
                        Container(
                            width: inputWidth,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              color: BASIC_GREY.withOpacity(0.1),
                            ),
                            child: Center(
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.datetime,
                                controller: dayController,
                                focusNode: dayFocusNode,
                                onChanged: (value) {
                                  setState(() {
                                    day = value;
                                  });
                                },
                                maxLength: 2,
                                decoration: InputDecoration(
                                  counterText: '',
                                  hintText: "일",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                    ),

                    // 시작하기 버튼
                    GestureDetector(
                      onTap: () {
                        context.read<UserStore>().setYear(year);
                        context.read<UserStore>().setMonth(month);
                        context.read<UserStore>().setDay(day);
                        context.read<UserStore>().signUpEssential(context); // 생년월일 및 성별 포함 회원가입

                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => MainPageChild(),
                            transitionsBuilder: (c, a1, a2, child) =>
                                SlideTransition(
                                  position: Tween(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset(0.0, 0.0),
                                  )
                                      .chain(CurveTween(curve: Curves.easeInOut))
                                      .animate(a1),
                                  child: child,
                                ),
                            transitionDuration: Duration(milliseconds: 750),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.redAccent.withOpacity(0.9), // 원의 배경색
                        ),
                        child: Text(
                          '필린 시작하기',
                          style: TextStyle(
                            color: Colors.white, // 텍스트의 색상
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
