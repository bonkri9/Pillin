import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourpilling/component/common/base_container.dart';
import 'package:http/http.dart' as http;
import '../../const/colors.dart';
import '../../const/url.dart';
import '../../store/user_store.dart';
import '../Login/login_screen.dart';

class UserInfoUpdateScreen extends StatefulWidget {
  const UserInfoUpdateScreen({super.key});

  @override
  State<UserInfoUpdateScreen> createState() => _UserInfoUpdateScreenState();
}

class _UserInfoUpdateScreenState extends State<UserInfoUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text("정보 변경"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            _NameChange(),
            SizedBox(
              height: 50,
            ),
            _PasswordChange(),
          ],
        ),
// =======
//       body: Column(
//         children: [
//           Row(
//             children: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     size: 18,
//                   )),
//               Text('마이 페이지', style: TextStyle(
//                 fontSize:TITLE_FONT_SIZE,
//                 color: BASIC_BLACK,
//               ),),
//             ],
//           ),
//           Expanded(
//             child: BaseContainer(width: 500, color: Colors.white, height: 25, child:
//             Column(
//               children: [
//                 Text(
//                   '이메일 ${userDetailInfo['email']}',
//                   style: TextStyle(
//                     fontSize: TITLE_FONT_SIZE+5,
//                   ),
//                 ),
//                 Text(
//                   '이름 ${userDetailInfo['name']}',
//                   style: TextStyle(
//                     fontSize: TITLE_FONT_SIZE+5,
//                   ),
//                 ),
//                 Text(
//                   '가입일 ${userDetailInfo['createAt'].substring(0, 10)}',
//                   style: TextStyle(
//                     fontSize: TITLE_FONT_SIZE+5,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 BaseContainer(
//                   color: Colors.white,
//                     width: 200,
//                     height: 35,
//                     child: TextButton(
//                       onPressed: () {
//                         context.read<UserStore>().deleteToken(); // 로그아웃
//                         Navigator.pushNamedAndRemoveUntil(
//                             context, '/', (_) => false);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()),
//                         );
//                       },
//                       child: Text('로그아웃'),
//                     )),
//                 BaseContainer(
//                   color: Colors.white,
//                     width: 200,
//                     height: 35,
//                     child: TextButton(
//                       onPressed: () {
//                         context
//                             .read<UserStore>()
//                             .deleteUserData(context); // 회원탈퇴
//                         Navigator.pushNamedAndRemoveUntil(
//                             context, '/', (_) => false);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()),
//                         );
//                       },
//                       child: Text('회원탈퇴'),
//                     )),
//               ],
//             )),
//           )
//         ],
// >>>>>>> Stashed changes
      ),
    );
  }
}

class _NameChange extends StatefulWidget {
  const _NameChange({super.key});

  @override
  State<_NameChange> createState() => _NameChangeState();
}

class _NameChangeState extends State<_NameChange> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusNode _nameFocus = new FocusNode();
    bool isValidateName() {
      if (nameController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("이름을 입력해주세요")));
        return false;
      }
      return true;
    }

    var nameNew;
    var UserDetail;
    var userDetailInfo = context.read<UserStore>().UserDetail;
    var nameOrigin = userDetailInfo['name'];

    setName(nameInput) {
      nameNew = nameInput;
    }

    //이름 변경 api
    changeName() async {
      String accessToken = context.read<UserStore>().accessToken;
      const String changeNameUrl = "${CONVERT_URL}/api/v1/member/name";

      print('try밖');
      print(nameNew);

      try {
        var response = await http.put(Uri.parse(changeNameUrl),
            headers: {
              'Content-Type': 'application/json',
              'accessToken': accessToken,
            },
            body: json.encode({
              'name': nameNew,
            }));
        print('try속');
        print(nameNew);

        print(response.body);

        if (response.statusCode == 200) {
          print("이름 변경 성공");

          UserDetail = jsonDecode(utf8.decode(response.bodyBytes));
        } else {
          print("이름 변경 실패");
        }
      } catch (error) {
        print(error);
      }
    }

    //이름 변경 내용
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "이름 변경",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            focusNode: _nameFocus,
            controller: nameController,
            onChanged: (value) {
              setName(value);
            },
            decoration: InputDecoration(
                hintText: nameOrigin,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.purple.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person)),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            if (isValidateName()) {
              changeName();
              print('유효 데이터');
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('알림'),
                    content: Text('이름이 변경되었습니다.'),
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
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            backgroundColor: Colors.redAccent,
          ),
          child: const Text(
            "이름 수정 완료",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordChange extends StatefulWidget {
  const _PasswordChange({super.key});

  @override
  State<_PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<_PasswordChange> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordVerifyingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusNode _passwordFocus = new FocusNode();
    FocusNode _passwordVerifyingFocus = new FocusNode();

    bool isValidatePassword() {
      if (passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("새 비밀번호를 입력해주세요")));
        return false;
      }
      return true;
    }

    bool isValidateVerifytingPassword() {
      if (passwordVerifyingController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("새 비밀번호를 재확인해주세요")));
        return false;
      }
      return true;
    }

    var passwordNew;
    var UserDetail;
    var userDetailInfo = context.read<UserStore>().UserDetail;
    var passwordOrigin = userDetailInfo['password'];

    setPassword(passwordInput) {
      passwordNew = passwordInput;
    }

    //비밀번호 변경 api
    changePassword() async {
      String accessToken = context.read<UserStore>().accessToken;
      const String changePasswordUrl = "${CONVERT_URL}/api/v1/member/password";

      print('try밖');
      print(passwordNew);

      try {
        var response = await http.put(Uri.parse(changePasswordUrl),
            headers: {
              'Content-Type': 'application/json',
              'accessToken': accessToken,
            },
            body: json.encode({
              'password': passwordNew,
            }));
        print('try속');
        print(passwordNew);

        print(response.body);

        if (response.statusCode == 200) {
          print("비밀번호 변경 성공");

          UserDetail = jsonDecode(utf8.decode(response.bodyBytes));
        } else {
          print("비밀번호 변경 실패");
        }
      } catch (error) {
        print(error);
      }
    }

    //비밀번호 변경 내용
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "비밀번호 변경",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            focusNode: _passwordFocus,
            controller: passwordController,
            onChanged: (value) {
              setPassword(value);
            },
            decoration: InputDecoration(
                hintText: "비밀번호",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.purple.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person)),
            obscureText: true,

          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: TextFormField(
            keyboardType: TextInputType.name,
            focusNode: _passwordVerifyingFocus,
            controller: passwordVerifyingController,
            onChanged: (value) {
              setPassword(value);
            },
            decoration: InputDecoration(
                hintText: "비밀번호 재확인",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person)),
            obscureText: true,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            if (isValidatePassword()) {
              if (isValidateVerifytingPassword()) {
                if (passwordController.text !=
                    passwordVerifyingController.text) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('알림'),
                          content: Text("입력한 비밀번호가 일치하지 않습니다."),
                          actions: [
                            TextButton(
                              child: Text("닫기"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  changePassword();
                  print('유효 데이터');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('알림'),
                        content: Text('비밀번호가 변경되었습니다.'),
                        actions: [
                          TextButton(
                            child: Text('닫기'),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            backgroundColor: Colors.redAccent,
          ),
          child: const Text(
            "비밀번호 수정 완료",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
