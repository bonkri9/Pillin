import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourpilling/component/kakao/kakao_login.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Login/login_screen.dart';
import 'package:yourpilling/screen/SignUp/greeting_screen.dart';
import 'package:yourpilling/store/user_store.dart';
import '../Main/main_page_child_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TokenCheck extends StatefulWidget {
  const TokenCheck({super.key});

  @override
  State<TokenCheck> createState() => _TokenCheckState();
}

class _TokenCheckState extends State<TokenCheck> {
  bool isToken = false;

  @override
  void initState() {
    super.initState();
    _autoLoginCheck();
  }

  void _autoLoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    print('토큰 여부 : ');
    print(isToken);
    if (token != null) {
      setState(() {
        isToken = true;
        context.read<UserStore>().accessToken = token;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('위젯 안 토큰 여부');
    print(isToken);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isToken ? MainPageChild() : EnterLoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EnterLoginScreen extends StatefulWidget {
  const EnterLoginScreen({super.key});

  @override
  State<EnterLoginScreen> createState() => _EnterLoginScreenState();
}

class _EnterLoginScreenState extends State<EnterLoginScreen> {
  var email;
  var password;
  var accessToken; // 일단 이렇게 설정해놓음

  // 자동 로그인 여부
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();
    var inputWidth = MediaQuery.of(context).size.width * 0.82;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // 0xFFF5F6F9
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                SizedBox(
                  height: 80,
                ),
                KakaoLogin(),
                SizedBox(
                  height: 15,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent.withOpacity(0.95),
                    ),
                    width: inputWidth,
                    height: 55,
                    child: TextButton(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.email, color: Colors.white),
                          SizedBox(
                            width: 85,
                          ),
                          Text(
                            "이메일 로그인",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    )),
                SizedBox(
                  height: 40,
                ),
                _signup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Image(
          image: AssetImage('assets/logo/pillin_logo.png'),
          width: 300,
        ),
      ],
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pillin 계정이 없으신가요? ",
          style: TextStyle(color: BASIC_BLACK.withOpacity(0.7), fontSize: 13),
        ),
        GestureDetector(
          child: Text(
            "회원가입",
            style: TextStyle(color: Colors.redAccent, fontSize: 13),
          ),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(pageBuilder: (c, a1, a2) => GreetingScreen(),
                transitionsBuilder: (c, a1, a2, child) =>
                    FadeTransition(opacity: a1, child: child,),
                transitionDuration: Duration(milliseconds: 700),
              ),
            );
          },
        )
      ],
    );
  }
}
