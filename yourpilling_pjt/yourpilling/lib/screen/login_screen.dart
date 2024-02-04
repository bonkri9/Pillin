import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/kakao/kakao_login.dart';
import 'package:yourpilling/component/sign_up/sign_up_screen.dart';
import 'package:yourpilling/screen/find_password_screen.dart';
import 'package:yourpilling/screen/main_screen.dart';
import 'package:yourpilling/store/user_store.dart';
import 'main_page_child_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    String url = "http://10.0.2.2:8080/api/v1/login";

    login() async {
      try {
        print("로그인 요청");
        var response = await http.post(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
        }
            , body: json.encode({
              'email': email,
              'password': password,
            }));


        print(response.body);
        if (response.statusCode == 200) {
          print("로그인 성공");
          var accessToken = response
              .headers['accesstoken']; // 이거 Provider 로 전역에 저장해보자
          print(accessToken);
          context.read<UserStore>().getToken(accessToken!); // provider에 받은 토큰 저장
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPageChild()));
        }else{
          falseDialog(context);
        }
      } catch(error) {
        print(error);
      }
    }

    setEmail(emailInput) {
      email = emailInput;
    }

    setPassword(passwordInput) {
      password = passwordInput;
    }


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context, emailController, passwordController, setEmail, setPassword, login),
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
        Image(image: AssetImage('assets/logo/pillin_logo.png'), width: 400,),
        // Text(
        //   "환영합니다",
        //   style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        // ),
        // Text("이메일과 비밀번호를 입력해주세요"),
      ],
    );
  }

  _inputField(context, emailController, passwordController, setEmail, setPassword, login) {

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
        KakaoLogin(), // 카카오로그인
         const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            login();
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
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FindPasswordScreen()));
      },
      child: const Text("비밀번호 찾기",
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
            child: const Text("회원가입", style: TextStyle(color: Colors.redAccent),)
        )
      ],
    );
  }
}


// 틀린 로그인일때 출력되는 팝업
void falseDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: 200,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("회원정보가 존재하지 않습니다."),
            ],
          ),
        ),
      );
    },
  );
}