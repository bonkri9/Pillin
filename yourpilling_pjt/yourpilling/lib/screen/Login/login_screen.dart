import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourpilling/component/kakao/kakao_login.dart';
import 'package:yourpilling/const/url.dart';
import 'package:yourpilling/screen/Login/sign_up_screen.dart';
import 'package:yourpilling/screen/Login/find_password_screen.dart';
import 'package:yourpilling/store/user_store.dart';
import '../../const/url.dart';
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
      home: isToken ? MainPageChild() : LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var email;
  var password;
  var accessToken; // 일단 이렇게 설정해놓음

  // 자동 로그인 여부
  bool switchValue = false;

  //이메일과 비밀번호 정보
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 자동 로그인 설정
  void _setAutoLogin(String token) async {
    // 공유저장소에 유저 DB의 인덱스 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // 자동 로그인 해제
  void _delAutoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();

    // String url = "https://i10b101.p.ssafy.io/api/v1/login";



    String url = "${CONVERT_URL}/api/v1/login";


    login(String email, String password) async {
      try {
        print(email);
        print('이메일');
        print(password);
        print('비밀번호');
        print("로그인 요청");
        var response = await http.post(Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'email': email,
              'password': password,
            }));

        print(response.body);
        if (response.statusCode == 200) {
          print("로그인 성공");
          var accessToken =
              response.headers['accesstoken']; // 이거 Provider 로 전역에 저장해보자
          print(accessToken);
          print('액세스토큰');
          context
              .read<UserStore>()
              .getToken(accessToken!); // provider에 받은 토큰 저장
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPageChild()));

          return accessToken;
        }
      } catch (error) {
        print(error);
      }
      // 예외처리용 에러코드 '-1' 반환
      return '-1';
    }

    setEmail(emailInput) {
      email = emailInput;
    }

    setPassword(passwordInput) {
      password = passwordInput;
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF), // 0xFFF5F6F9
      body: Container(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context, emailController, passwordController,
                  setEmail, setPassword, login),
              _forgotPassword(context),
              _signup(context),
            ],
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
          width: 400,
        ),
        // Text(
        //   "환영합니다",
        //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        // ),
        // Text("이메일과 비밀번호를 입력해주세요"),
      ],
    );
  }

  _inputField(context, emailController, passwordController, setEmail,
      setPassword, login) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 40),
        TextField(
          controller: emailController,
          onChanged: (value) {
            setEmail(value); // 이 부분에서 이름을 state에 저장합니다.
          },
          decoration: InputDecoration(
              hintText: "이메일",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          onChanged: (value) {
            setPassword(value); // 이 부분에서 이름을 state에 저장합니다.
          },
          decoration: InputDecoration(
            hintText: "비밀번호",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        KakaoLogin(), // 카카오 로그인
        const SizedBox(height: 20),
        //로그인 버튼
        ElevatedButton(
          onPressed: () async {
            final loginCheck = await login(emailController.text, passwordController.text);
            print('로그인 버튼 눌림');
            print(loginCheck);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => MainPageChild()));

            // 로그인 확인
            if (loginCheck == '-1') {
              print('로그인 실패');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('알림'),
                    content: Text('아이디 또는 비밀번호가 올바르지 않습니다.'),
                    actions: [
                      TextButton(
                        child: Text('닫기'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              print('로그인 성공');
              print(switchValue);
              // 자동 로그인 확인
              if (switchValue == true) {
                _setAutoLogin(loginCheck!);
              } else {
                _delAutoLogin();
              }

              // 메인 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPageChild(),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.redAccent,
          ),
          child: const Text(
            "로그인",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Row(
          children: [
            Text(
              '자동로그인 ',
              style:
                  TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            CupertinoSwitch(
              // boolean 값으로 스위치 토글 (value)
              value: switchValue,
              activeColor: Colors.redAccent,
              onChanged: (bool? value) {
                // 스위치가 토글될 때 실행될 코드
                setState(() {
                  switchValue = value ?? false;
                });
              },
            ),
          ],
        ),

      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FindPasswordScreen()));
      },
      child: const Text(
        "비밀번호 찾기",
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Pillin 계정이 없으신가요? "),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: const Text(
              "회원가입",
              style: TextStyle(color: Colors.redAccent),
            ))
      ],
    );
  }
}
