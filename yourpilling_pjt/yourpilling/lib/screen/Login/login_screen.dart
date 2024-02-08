import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:yourpilling/const/url.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Login/find_password_screen.dart';
import 'package:yourpilling/screen/Main/main_screen.dart';
import 'package:yourpilling/screen/SignUp/more_info_screen.dart';
import 'package:yourpilling/store/user_store.dart';
import '../Main/main_page_child_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool switchValue = true;

  // 처음 로그인 한지 안한지에 따라 페이지 이동
  bool isFirstLogin = true;

  //이메일과 비밀번호 정보
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Focus Node
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  bool isValidEmail(String email) {
    // 정규 표현식을 사용하여 이메일 형식 검사
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }


  bool isValidate() {
    if (emailController.text.isEmpty) {
      Vibration.vibrate(duration: 300); // 진동
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(shape: RoundedRectangleBorder( // ShapeDecoration을 사용하여 borderRadius 적용
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ), content: Text("이메일을 입력해주세요", style: TextStyle(color: BASIC_BLACK),), backgroundColor: Colors.yellow, duration: Duration(milliseconds: 1100),));
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
      Vibration.vibrate(duration: 300); // 진동
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(shape: RoundedRectangleBorder( // ShapeDecoration을 사용하여 borderRadius 적용
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ), content: Text("비밀번호를 입력해주세요", style: TextStyle(color: BASIC_BLACK),), backgroundColor: Colors.yellow, duration: Duration(milliseconds: 1100),));
      return false;
    }
    return true;
  }


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
    String url = "${CONVERT_URL}/api/v1/login";


    login(String email, String password) async {
      try {
        print('$email $password');
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
          print('response header : ${response.headers}');
          print(accessToken);
          context
              .read<UserStore>()
              .getToken(accessToken!); // provider에 받은 토큰 저장
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => MainPageChild()));

          setState(() {
            isFirstLogin = response.headers['isfirstlogin'] == 'true'
                ? true
                : false; // 첫번째 로그인인지 여부 설정
          });

          print(isFirstLogin);

          if (isFirstLogin) {
            print("첫번째 로그인임");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MoreInfoScreen()));
          } else {
            print("첫번째 로그인 아님");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPageChild()));
          }
          return accessToken;
        }
      } catch (error) {
        print(error);
        return -1; // 에러 시 -1 반환
      }
    }

    setEmail(emailInput) {
      email = emailInput;
    }

    setPassword(passwordInput) {
      password = passwordInput;
    }

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
                SizedBox(height: 30,),
                _inputField(context, emailController, passwordController,
                    setEmail, setPassword, login, isValidate),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Lottie.asset('assets/lottie/heart.json',
        fit: BoxFit.fill,
        width: 300,
        height: 300),
      ],
    );
  }

  _inputField(context, emailController, passwordController, setEmail,
      setPassword, login, isValidate) {
    var inputWidth = MediaQuery.of(context).size.width * 0.82;
    return Column(
      children: [
        // SizedBox(height: 10),
        SizedBox(
          width: inputWidth,
          height: 55,
          child: TextField(
            controller: emailController,
            focusNode: emailFocusNode,
            onChanged: (value) {
              setEmail(value); // 이 부분에서 이름을 state에 저장합니다.
            },
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            decoration: InputDecoration(
                hintText: "이메일",
                hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),

                    borderSide: BorderSide.none),
                fillColor: BASIC_GREY.withOpacity(0.15),
                filled: true,
                prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade500)),
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: inputWidth,
          height: 55,
          child: TextField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            onChanged: (value) {
              setPassword(value);
            },
            decoration: InputDecoration(
              hintText: "비밀번호",
              hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              fillColor: BASIC_GREY.withOpacity(0.15),
              filled: true,
              prefixIcon: Icon(Icons.password_outlined, color: Colors.grey.shade500),
            ),
            obscureText: true,
          ),
        ),
        SizedBox(height: 5),
        SizedBox(height: 30),
        //로그인 버튼
        SizedBox(
          width: inputWidth,
          child: ElevatedButton(
            onPressed: () async {
              if(isValidate()) {
                final loginCheck = await login(
                    emailController.text, passwordController.text);
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
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.redAccent,

            ),
            child: Text(
              "로그인",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 10,),
        _forgotPassword(context),
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FindPasswordScreen()));
      },
      child: Text(
        "비밀번호 생각 안나시나요",
        style: TextStyle(color: BASIC_BLACK.withOpacity(0.7), decoration: TextDecoration.underline, fontSize: 13),
      ),
    );
  }
}
