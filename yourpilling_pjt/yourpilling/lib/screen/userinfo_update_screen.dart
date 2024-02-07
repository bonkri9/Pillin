import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/base_container.dart';

import '../const/colors.dart';
import '../store/user_store.dart';
import 'login_screen.dart';

class UserInfoUpdateScreen extends StatefulWidget {
  const UserInfoUpdateScreen({super.key});

  @override
  State<UserInfoUpdateScreen> createState() => _UserInfoUpdateScreenState();
}

class _UserInfoUpdateScreenState extends State<UserInfoUpdateScreen> {



  @override
  Widget build(BuildContext context) {
     var userDetailInfo = context.read<UserStore>().UserDetail;
    // print('userDetailInfo=' + userDetailInfo["data"]);

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  )),
              Text('마이 페이지', style: TextStyle(
                fontSize:TITLE_FONT_SIZE,
                color: BASIC_BLACK,
              ),),
            ],
          ),
          Expanded(
            child: BaseContainer(width: 500, height: 25, child:
            Column(
              children: [
                Text(
                  '이메일 ${userDetailInfo['email']}',
                  style: TextStyle(
                    fontSize: TITLE_FONT_SIZE+5,
                  ),
                ),
                Text(
                  '이름 ${userDetailInfo['name']}',
                  style: TextStyle(
                    fontSize: TITLE_FONT_SIZE+5,
                  ),
                ),
                // Text(
                //   '닉네임 ${userDetailInfo['nickname']}',
                //   style: TextStyle(
                //     fontSize: TITLE_FONT_SIZE+5,
                //   ),
                // ),
                // Text(
                //   '생일 ${userDetailInfo['birthday']}',
                //   style: TextStyle(
                //     fontSize: TITLE_FONT_SIZE+5,
                //   ),
                // ),
                // Text(
                //   '성별 ${userDetailInfo['gender']}',
                //   style: TextStyle(
                //     fontSize: TITLE_FONT_SIZE+5,
                //   ),
                // ),
                Text(
                  '가입일 ${userDetailInfo['createAt'].substring(0, 10)}',
                  style: TextStyle(
                    fontSize: TITLE_FONT_SIZE+5,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BaseContainer(
                    width: 200,
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        context.read<UserStore>().deleteToken(); // 로그아웃
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('로그아웃'),
                    )),
                BaseContainer(
                    width: 200,
                    height: 35,
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<UserStore>()
                            .deleteUserData(context); // 회원탈퇴
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('회원탈퇴'),
                    )),
              ],
            )),
          )
        ],
      ),
    );
  }
}
