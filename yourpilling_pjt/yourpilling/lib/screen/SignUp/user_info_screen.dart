import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';
import 'package:yourpilling/screen/Login/login_screen.dart';
import 'package:yourpilling/screen/SignUp/greeting_screen.dart';
import 'package:yourpilling/store/user_store.dart';

import '../../const/colors.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String email = '';
  String password = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;


  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }




  bool isValidEmail(String email) {
    // 정규 표현식을 사용하여 이메일 형식 검사
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidate() {
    if (emailController.text.isEmpty) {
      Vibration.vibrate(duration: 300); // 진동
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
          // ShapeDecoration을 사용하여 borderRadius 적용
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        content: Text(
          "이메일을 입력해주세요",
          style: TextStyle(color: BASIC_BLACK),
        ),
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 1100),
      ));
      return false;
    } else if (!isValidEmail(emailController.text)) {
      Vibration.vibrate(duration: 300); // 진동
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
          // ShapeDecoration을 사용하여 borderRadius 적용
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        content: Text(
          "올바른 이메일 형식이 아니에요",
          style: TextStyle(color: BASIC_BLACK),
        ),
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 1100),
      ));
      return false;
    }

    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
          // ShapeDecoration을 사용하여 borderRadius 적용
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        content: Text(
          "비밀번호를 입력해주세요",
          style: TextStyle(color: BASIC_BLACK),
        ),
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 1100),
      ));
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width * 0.9;
    var inputWidth = MediaQuery.of(context).size.width * 0.8;
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
                          text: '제가 찾던 ',
                          style: TextStyle(
                            fontSize: 26,
                            color: BASIC_BLACK,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: context.watch<UserStore>().userName,
                          style: TextStyle(
                            color: Colors.redAccent, // 영양이 부분의 색상을 빨간색으로 지정
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '님이군요!',
                          style: TextStyle(
                            fontSize: 26,
                            color: BASIC_BLACK,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "바로 회원 등록 하실게요.",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                ],
              ),
              Column(
                children: [
                  // 이메일 입력란
                  Container(
                      width: inputWidth,
                      height: 60,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade200, width: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        color: BASIC_GREY.withOpacity(0.15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Center(
                          child: TextField(
                            controller: emailController,
                            focusNode: emailFocusNode,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(passwordFocusNode);
                            },
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "이메일을 입력해주세요.",
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
                    height: 20,
                  ),
                  // 이메일 입력란
                  Container(
                      width: inputWidth,
                      height: 60,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade200, width: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        color: BASIC_GREY.withOpacity(0.15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Center(
                          child: TextField(
                            controller: passwordController,
                            focusNode: passwordFocusNode,
                            obscureText: true,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "비밀번호를 입력해주세요.",
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
                    height: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // 닉네임 다시 설정
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => GreetingScreen(),
                            transitionsBuilder: (c, a1, a2, child) =>
                                SlideTransition(
                              position: Tween(
                                begin: Offset(-1.0, 0.0),
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
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 0.7,
                            color: Colors.redAccent,
                          ),
                          color: Colors.white,
                        ),
                        child: Text(
                          '이름 바꿀래요',
                          style: TextStyle(
                            color: Colors.redAccent, // 텍스트의 색상
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    // 회원가입 요청
                    GestureDetector(
                      onTap: () async {
                        try{
                          context.read<UserStore>().userEmail = email;
                          context.read<UserStore>().password = password;
                          await context.read<UserStore>().signUp(context);
                          if (isValidate()) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            // 회원가입 성공 시 이름이랑 닉네임 페이지 사라지게
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => LoginScreen(),
                                transitionsBuilder: (c, a1, a2, child) =>
                                    SlideTransition(
                                      position: Tween(
                                        begin: Offset(-1.0, 0.0),
                                        end: Offset(0.0, 0.0),
                                      )
                                          .chain(CurveTween(curve: Curves.easeInOut))
                                          .animate(a1),
                                      child: child,
                                    ),
                                transitionDuration: Duration(milliseconds: 750),
                              ),
                            );
                          }
                        }catch(e){
                          Vibration.vibrate(duration: 300); // 진동
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            shape: RoundedRectangleBorder(
                              // ShapeDecoration을 사용하여 borderRadius 적용
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            ),
                            content: Text(
                              "이미 가입된 이메일입니다!",
                              style: TextStyle(color: BASIC_BLACK),
                            ),
                            backgroundColor: Colors.yellow,
                            duration: Duration(milliseconds: 1100),
                          ));
                        }

                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.redAccent.withOpacity(0.9), // 원의 배경색
                        ),
                        child: Text(
                          '등록하기',
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
