import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourpilling/component/login/member_register.dart';
import 'package:yourpilling/screen/main_page_child_screen.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginMainScreen(),
    );
  }
}

class LoginMainScreen extends StatefulWidget {
  const LoginMainScreen({super.key});

  @override
  State<LoginMainScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginMainScreen> {
  // 자동 로그인 여부
  bool switchValue = false;

  // 아이디, 비밀번호 정보
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //아이디 입력 필드
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: CupertinoTextField(
                      controller: userIdController,
                      placeholder: '아이디를 입력해주세요',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                //비밀번호 입력 필드
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: CupertinoTextField(
                      controller: passwordController,
                      placeholder: '비밀번호를 입력해주세요',
                      textAlign: TextAlign.center,
                      obscureText: true,
                    ),
                  ),
                ),
                //자동 로그인 토글
                SizedBox(
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //   icon: Icon(Icons.arrow_back_ios_new_rounded,
                      //       color: Colors.black),
                      //   onPressed: () {
                      //     Navigator.pop(context);
                      //   },
                      // ),
                      Text(
                        '자동로그인',
                        style: TextStyle(
                          color: Color(0xFFFF6666),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CupertinoSwitch(
                        //boolean으로 자동로그인 여부
                        value: switchValue,
                        activeColor: Color(0xFFFF6666),
                        onChanged: (bool? value) {
                          //스위치 토글 시 실행될 코드
                          setState(() {
                            switchValue = value ?? false;
                          });
                        },
                      ),
                      Text('    '),
                      //회원가입 페이지로 이동 버튼
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemberRegister(),
                              // builder: (context)=>MainScreen(),
                            ),
                          );
                        },
                        child: Text(
                          '계정생성',
                        ),
                      ),
                    ],
                  ),
                ),
                //로그인 버튼
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPageChild(),
                          ),
                        );
                      },
                      child: Text('로그인(일단 홈으로)'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
