import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Main/main_page_child_screen.dart';
import 'package:yourpilling/widgets/input_field_widget.dart';
import 'package:yourpilling/widgets/primary_button.dart';

import 'regist_signup_screen.dart';

class LoginScreenView extends StatefulWidget {
  const LoginScreenView({super.key});

  @override
  State<LoginScreenView> createState() => _LoginScreenViewState();
}

class _LoginScreenViewState extends State<LoginScreenView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image(image: AssetImage('assets/logo/pillin_logo.png'), width: 350,),
              ],
            ),
            const Text(
              '환영합니다!',
              style: TextStyle(
                color: Colors.white,
                fontFamily: fontFamily,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              '아래 빈칸을 작성해주세요',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            InputField(
                controller: emailController,
                hintText: '이메일',
                icon: Icons.email
            ),
            const SizedBox(
              height: 25,
            ),
            InputField(
                controller: passwordController,
                hintText: '비밀번호',
                icon: Icons.password,
              obscureText: true,
            ),
            const SizedBox(
              height: 70,
            ),
            PrimaryButton(text: '로그인', onPressed: (){
              if(isValidate()){
                print('유효한 데이터');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPageChild()));
              }
            }),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '아직 계정이 없으신가요?',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontFamily,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> SignupScreenView()));
                  },
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
                    ],
                  ),
          )),
    );
  }

  bool isValidate(){

    // if(emailController.text.isEmpty){
    //   showScaffold(context, '이메일을 입력해주세요');
    //   return false;
    // }
    // if(passwordController.text.isEmpty){
    //   showScaffold(context, '비밀번호를 입력해주세요');
    //   return false;
    // }
    return true;
  }
}
