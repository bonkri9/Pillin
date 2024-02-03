import 'package:flutter/material.dart';
import '../../screen/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    var name;
    var email;
    var password;
    var url = "http://10.0.2.2:8080/api/v1/register";

    signUp() async {
      try {
        var response = await http.post(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
        }
            , body: json.encode({
              'name': name,
              'email': email,
              'password': password,
            }));
        print(response);

        if (response.statusCode == 200) {
          print("회원가입 성공");
          corretDialog(context);
        }else{
          throw Exception('회원가입 실패');
        }
      } catch (error) {
        falseDialog(context);
        print('올바르지않은이메일');
        print(error);
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(height: 60.0),
                    const Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "개인정보를 입력해주세요",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      onChanged: (value) {
                          name = value;
                      },
                      decoration: InputDecoration(
                          hintText: "이름",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.purple.withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.person)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      onChanged: (value) {
                          email = value; // 이 부분에서 이름을 state에 저장합니다.
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
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      onChanged: (value) {
                          password = value; // 이 부분에서 이름을 state에 저장합니다.
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
                    const SizedBox(height: 20),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Text(
                        "완료",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("이미 Pillin 회원이시군요?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.redAccent),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



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
              const Text("올바르지 않은 입력입니다."),
            ],
          ),
        ),
      );
    },
  );
}

void corretDialog(context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen()));
          return true;
        },
        child: Dialog(
          child: Container(
            width: 200,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("회원가입 성공"),
              ],
            ),
          ),
        ),
      );
    },
  );
}