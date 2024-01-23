import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourpilling/component/login/login_db.dart';

class MemberRegister extends StatefulWidget {
  const MemberRegister({Key? key}) : super(key: key);

  @override
  State<MemberRegister> createState() => _MemberRegisterState();
}

class _MemberRegisterState extends State<MemberRegister> {
  // 아이디와 비밀번호의 정보 저장
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordVerifyingController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // 아이디 입력 필드
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                // 비밀번호 입력 필드
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
                // 비밀번호 재확인 필드
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 300,
                    child: CupertinoTextField(
                      controller: passwordVerifyingController,
                      placeholder: '비밀번호를 다시 입력해주세요',
                      textAlign: TextAlign.center,
                      obscureText: true,
                    ),
                  ),
                ),
                // 로그인 페이지로 리턴
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('뒤로 가기'),
                        ),
                      ),
                      Text('   '),
                      // 계정 생성 버튼
                      SizedBox(
                        width: 195,
                        child: ElevatedButton(
                          onPressed: () async{
                            //아이디 중복 확인
                            // final idCheck =
                            //     await confirmIdCheck(userIdController.text);
                            // print('idCheck : $idCheck');
                            //
                            // //아이디 중복이면 1 리턴, 아니면 0 리턴
                            // if(idCheck != '0'){
                            //   showDialog(
                            //       context: context,
                            //       builder: (BuildContext context){
                            //         return AlertDialog(
                            //           title: Text('워닝워닝!!'),
                            //           content: Text('입력한 아이디는 이미 있는데용? 다른 아이디 고고하삼'),
                            //           actions: [
                            //             TextButton(
                            //               child: Text('닫기'),
                            //               onPressed: () {
                            //                 Navigator.of(context).pop();
                            //               },
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //   );
                            // }
                            //
                            // //비밀번호 확인이 다를 경우
                            // else if(passwordController.text != passwordVerifyingController.text){
                            //   showDialog(
                            //       context: context,
                            //       builder: (BuildContext context){
                            //         return AlertDialog(
                            //           title: Text('워어어닝'),
                            //           content: Text('마! 비번이 다른데 우짤기고?!'),
                            //           actions: [
                            //             TextButton(
                            //                 onPressed: () {
                            //                   Navigator.of(context).pop();
                            //                 },
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //   );
                            // }
                            //mariaDB에 계정 등록
                            // else{
                            //   insertMember(userIdController.text,
                            //   passwordController.text);
                            //   showDialog(
                            //       context: context,
                            //       builder: (BuildContext context){
                            //         return AlertDialog(
                            //           title: Text('축하해용~'),
                            //           content: Text('아이디가 생성되었다구요~!'),
                            //           actions: [
                            //             TextButton(
                            //                 onPressed: (){
                            //                   Navigator.of(context).pop();
                            //                 },
                            //                 child: Text('닫기'),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //   );
                            // }
                          },
                          child: Text('계정 생성'),
                        ),
                      ),
                    ],
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