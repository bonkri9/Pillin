import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yourpilling/component/login/regist_login_screen.dart';
import 'package:yourpilling/const/colors.dart';

import '../../widgets/input_field_widget.dart';
import '../../widgets/primary_button.dart';
import '../login/login_screen.dart';

class SignupScreenView extends StatefulWidget {
  const SignupScreenView({super.key});

  @override
  State<SignupScreenView> createState() => _SignupScreenViewState();
}

class _SignupScreenViewState extends State<SignupScreenView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  String genderSelected = 'male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '잭잭이',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                '잭잭스',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const Center(
              child: Text(
                '여기에 정보를 입력해주세요',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            InputField(
              controller: nameController,
              icon: Icons.person,
              hintText: '이름',
            ),
            const SizedBox(
              height: 25,
            ),
            InputField(
              controller: emailController,
              icon: Icons.email,
              hintText: '이메일',
            ),
            const SizedBox(
              height: 25,
            ),
            InputField(
              controller: passwordController,
              icon: Icons.password,
              hintText: '비밀번호',
              obscureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 20),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: fontFamily,
                ),
                textAlign: TextAlign.center,
                controller: birthDateController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                    size: 25,
                  ),
                  hintText: '생년월일',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: fontFamily,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onTap: () async {
                  DateTime date = DateTime(1900);
                  FocusScope.of(context).requestFocus(FocusNode());
                  date = (await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100)))!;
                  String dateFormatter = date.toIso8601String();
                  DateTime dt = DateTime.parse(dateFormatter);
                  var formatter = DateFormat('dd-MMMM-yyyy');
                  birthDateController.text = formatter.format(dt);
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "성별",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 14,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: genderSelected,
                          activeColor: Colors.white,
                          title: const Text(
                            '남자',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: 'male',
                          onChanged: (value) {
                            setState(() {
                              genderSelected = value.toString();
                            });
                            print(genderSelected);
                          },
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          groupValue: genderSelected,
                          activeColor: Colors.white,
                          title: const Text(
                            '여자',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: 'female',
                          onChanged: (value) {
                            setState(() {
                              genderSelected = value.toString();
                            });
                            print(genderSelected);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            PrimaryButton(
              text: '완료',
              onPressed: (){
                if(isValidate()){
                  print('유효한 데이터');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '이미 계정이 있으신가요?',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: fontFamily,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> LoginScreenView()));
                  },
                  child: Text(
                    '로그인',
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
      ),
    );
  }

  bool isValidate(){

    if(nameController.text.isEmpty){
      showScaffold(context, '이름을 입력해주세요');
      return false;
    }
    if(emailController.text.isEmpty){
      showScaffold(context, '이메일을 입력해주세요');
      return false;
    }
    if(passwordController.text.isEmpty){
      showScaffold(context, '비밀번호를 입력해주세요');
      return false;
    }
    if(birthDateController.text.isEmpty){
      showScaffold(context, '생년월일을 입력해주세요');
      return false;
    }
    return true;
  }

}
