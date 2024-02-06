import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yourpilling/screen/login_screen.dart';
import 'package:http/http.dart' as http;
import '../const/colors.dart';

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({super.key});

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 터치하면 키보드꺼짐
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("비밀번호찾기"),
        ),
        backgroundColor: BACKGROUND_COLOR,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SearchBar(
              myController: myController,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController myController;

  const _SearchBar({Key? key, required this.myController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: '이메일을 입력하세요',
                hoverColor: BASIC_GREY,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              // 통신추가 - 희태
              try {
                findPassword(context, myController.text);
                // 절취선 이부분만 살리면 이전과 동일
                // 절취선 종료
              } catch (error) {
                print('체크2 실패');
                print(error);
              }

              // 통신끝 - 희태
            },
            child: Text('이메일 발송'),
          ),
        ],
      ),
    );
  }
}

// 비밀번호찾기
Future<void> findPassword(BuildContext context, email) async {
  print('체크1');
  // String url = 'http://10.0.2.2:8080/api/v1/password-reissue';

  String url = "http://10.0.2.2:8080/api/password-reissue";

  print('email은 ${email}');
  try {
    var response = await http.put(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }));

    print('체크2');
    print(response.body);
    if (response.statusCode == 200) {
      print("임시 비밀번호 발급 성공");
      corretDialog(context);
    } else {
      throw Exception('이메일 발송 실패 실패');
    }
  } catch (error) {
    print("잘못된 이메일을 넣으셨네요.");
    falseDialog(context);
    print(error);
  }
}
// 비밀번호 찾기 종료


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
              const Text("올바르지 못한 이메일"),
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
                const Text("임시비밀번호 발급 성공"),
              ],
            ),
          ),
        ),
      );
    },
  );
}