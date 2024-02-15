import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/screen/Login/login_screen.dart';
import 'package:yourpilling/screen/SignUp/greeting_screen.dart';
import 'package:yourpilling/screen/SignUp/last_info_screen.dart';
import 'package:yourpilling/store/user_store.dart';

import '../../const/colors.dart';

class MoreInfoScreen extends StatefulWidget {
  const MoreInfoScreen({super.key});

  @override
  State<MoreInfoScreen> createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width * 0.9;
    var inputWidth = MediaQuery.of(context).size.width * 0.83;
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
                            fontFamily: "Pretendard",
                            color: Colors.redAccent, // 영양이 부분의 색상을 빨간색으로 지정
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '님 성별은 어떻게 되시나요?',
                          style: TextStyle(
                            fontFamily: "Pretendard",
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
                    "필요한 영양성분이 다를 수 있어요",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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
                    // 남자에요
                    GestureDetector(
                      onTap: () {
                        context.read<UserStore>().setGender('MAN'); // 성별 저장
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => LastInfoScreen(),
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
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: Container(
                        width: inputWidth,
                        height: 60,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.lightBlueAccent, width: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.lightBlueAccent.withOpacity(0.08),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Center(
                            child: Text(
                              "남자에요",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // 여자에요
                    GestureDetector(
                      onTap: () {
                        context.read<UserStore>().setGender('WOMAN'); // 성별 저장
                        Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => LastInfoScreen(),
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
                            transitionDuration: Duration(milliseconds: 400),
                          ),
                        );
                      },
                      child: Container(
                        width: inputWidth,
                        height: 60,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.grey.shade200, width: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.yellow.withOpacity(0.1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Center(
                            child: Text(
                              "여자에요",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 30,
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
