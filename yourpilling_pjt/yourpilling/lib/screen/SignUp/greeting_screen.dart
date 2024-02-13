import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:yourpilling/component/common/base_container.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/SignUp/user_info_screen.dart';

import '../../store/user_store.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  String name = '';
  TextEditingController userNameController = TextEditingController();

  bool isValidate() {
    if (userNameController.text.isEmpty) {
      Vibration.vibrate(duration: 300); // 진동
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(shape: RoundedRectangleBorder( // ShapeDecoration을 사용하여 borderRadius 적용
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ), content: Text("이름을 입력해주세요", style: TextStyle(color: BASIC_BLACK),), backgroundColor: Colors.yellow, duration: Duration(milliseconds: 1100),));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width * 0.9;
    var inputWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth,
                child: Lottie.asset('assets/lottie/kickboard.json',
                    width: 300, height: 300),
              ),
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "반가워요",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '저는 영양 트레이너 ',
                            style: TextStyle(
                              fontSize: 24,
                              color: BASIC_BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '영양이',
                            style: TextStyle(
                              color: Colors.redAccent, // 영양이 부분의 색상을 빨간색으로 지정
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '에요!',
                            style: TextStyle(
                              fontSize: 24,
                              color: BASIC_BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "회원님 어떻게 불러드릴까요?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                        width: inputWidth,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade200, width: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          color: BASIC_GREY.withOpacity(0.15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Center(
                            child: TextField(
                              controller: userNameController,
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "ex) 영양실조",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            context.read<UserStore>().userName = name;
                            if (isValidate()) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => UserInfoScreen(),
                                  transitionsBuilder: (c, a1, a2, child) =>
                                      SlideTransition(
                                        position: Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0),
                                        )
                                            .chain(
                                            CurveTween(curve: Curves.easeInOut))
                                            .animate(a1),
                                        child: child,
                                      ),
                                  transitionDuration: Duration(
                                      milliseconds: 750),
                                ),
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundColor: Colors.redAccent, // 원의 배경색
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white, // 화살표 아이콘의 색상
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
