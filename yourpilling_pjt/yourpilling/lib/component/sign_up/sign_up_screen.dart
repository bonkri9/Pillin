import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../const/colors.dart';
import '../../screen/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var name;
  var email;
  var password;
  var birthday;
  var nickname;
  var gender;
  var userInfo;

  // String genderSelected = 'male';

  @override
  Widget build(BuildContext context) {
    // final TextEditingController nameController = TextEditingController();
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController passwordController = TextEditingController();
    // final TextEditingController birthdayController = TextEditingController();
    // final TextEditingController nicknameController = TextEditingController();

    signUp() async {
      // const String signupUrl = "https://i10b101.p.ssafy.io/api/v1/register";
      // const String signupUrl = "http://10.0.2.2:8080/api/v1/register";
      const String signupUrl = "http://localhost:8080/api/v1/register";
      try {
        print('회원가입 등록');
        var response = await http.post(Uri.parse(signupUrl),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'name': name,
              'email': email,
              'password': password,
              'nickname': nickname,
              'birthday': birthday,
              'gender': gender,
            }));
        userInfo = jsonDecode(utf8.decode(response.bodyBytes));
        print(response.body);
        print(userInfo);

        if (response.statusCode == 200) {
          print("회원가입 성공");
          corretDialog(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        } else {
          throw Exception('회원가입 실패');
        }
      } catch (error) {
        print(error);
      }
    }

    setName(nameInput) {
      name = nameInput;
    }

    setNickname(nicknameInput) {
      nickname = nicknameInput;
    }

    setPassword(passwordInput) {
      password = passwordInput;
    }

    setEmail(emailInput) {
      email = emailInput;
    }

    setBirthday(birthdayInput) {
      birthday = birthdayInput;
    }

    setGender(genderInput) {
      gender = genderInput;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        body: SingleChildScrollView(
          child: Column(
            // padding: const EdgeInsets.symmetric(horizontal: 40),
            // height: MediaQuery.of(context).size.height - 50,
            // width: double.infinity,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // child: Column(
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
              _inputField(
                  context,
                  birthdayController,
                  nameController,
                  nicknameController,
                  gender,
                  emailController,
                  passwordController,
                  setEmail,
                  setPassword,
                  setGender,
                  setNickname,
                  setBirthday,
                  setName,
                  signUp),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("이미 Pillin 회원이시군요?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
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
    );
  }
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  _inputField(
      context,
      birthdayController,
      nameController,
      nicknameController,
      gender,
      emailController,
      passwordController,
      setEmail,
      setPassword,
      setGender,
      setNickname,
      setBirthday,
      setName,
      signUp) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          onChanged: (value) {
            setName(value);
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
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        TextField(
          controller: nicknameController,
          onChanged: (value) {
            setNickname(value);
          },
          decoration: InputDecoration(
              hintText: "닉네임",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.purple.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: birthdayController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.calendar_month,
              size: 25,
            ),
            hintText: '생년월일',
            // focusedBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: Colors.white),
            // ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
          ),
          onTap: () async {
            DateTime date = DateTime(1900);
            FocusScope.of(context).requestFocus(FocusNode());
            date = (await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100)))!;
            String dateFormatter = date.toIso8601String();
            print(dateFormatter);
            DateTime dt = DateTime.parse(dateFormatter);
            print(dt);
            var formatter = DateFormat('yyyy-MM-dd');
            print(formatter);
            birthdayController.text = formatter.format(dt);
            print(birthdayController.text);
            setBirthday(birthdayController.text);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  groupValue: gender,
                  activeColor: Colors.redAccent,
                  title: Text(
                    '남자',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ), value: 'man',
                  onChanged: (value){
                    setState(() {
                      gender = value.toString();
                      setGender(gender);
                    });
                    print(gender);
                  },
                )),
            Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  groupValue: gender,
                  activeColor: Colors.redAccent,
                  title: Text(
                    '여자',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ), value: 'woman',
                  onChanged: (value){
                    setState(() {
                      gender = value.toString();
                      setGender(gender);
                    });
                    print(gender);
                  },
                )),
          ],
        ),
        ElevatedButton(
              onPressed: () {
                if (isValidate(context)) {
                  signUp();
                  print('유효 데이터');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => LoginScreen()));
                }
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
            ),
      ],
    );
  }

  bool isValidate(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("이름을 입력해주세요"))
      );
      // showScaffoldd(context, '이름을 입력해주세요');
      return false;
    }
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("이메일을 입력해주세요"))
      );
      // showScaffoldd(context, '이메일을 입력해주세요');
      return false;
    }
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("비밀번호를 입력해주세요"))
      );
      // showScaffoldd(context, '비밀번호를 입력해주세요');
      return false;
    }
    if (birthdayController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("생년월일을 입력해주세요"))
      );
      // showScaffoldd(context, '생년월일을 입력해주세요');
      return false;
    }
    if (nicknameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("닉네임을 입력해주세요"))
      );
      // showScaffoldd(context, '닉네임을 입력해주세요');
      return false;
    }
    return true;
  }

  showScaffoldd(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
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
