import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourpilling/component/common/base_container.dart';
import 'package:yourpilling/screen/Mypage/userinfo_update_screen.dart';

import '../../const/colors.dart';
import '../../store/user_store.dart';
import '../Login/login_screen.dart';

class UserInfoDetailScreen extends StatefulWidget {
  const UserInfoDetailScreen({super.key});

  @override
  State<UserInfoDetailScreen> createState() => _UserInfoDetailScreenState();
}

class _UserInfoDetailScreenState extends State<UserInfoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var userDetailInfo = context.watch<UserStore>().UserDetail;
    // print('userDetailInfo=' + userDetailInfo["data"]);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          "${userDetailInfo?['name'] ?? ""}님의 정보",
          style: TextStyle(
            color: BASIC_BLACK,
            fontSize: 25,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                width: 500,
                height: 25,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '이메일',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              Text(
                                '이름',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              // Text(
                              //   '닉네임',
                              //   style: TextStyle(
                              //     fontSize: TITLE_FONT_SIZE + 5,
                              //   ),
                              // ),
                              Text(
                                '성별',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              Text(
                                '생년월일',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              Text(
                                '가입일',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${userDetailInfo?['email'] ?? 0}',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              Text(
                                '${userDetailInfo?['name'] ?? ''}',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              // Text(
                              //   '${userDetailInfo?['nickname'] ?? ''}',
                              //   style: TextStyle(
                              //     fontSize: TITLE_FONT_SIZE + 5,
                              //   ),
                              // ),
                              Text(
                                userDetailInfo?['gender'] == 'MAN'
                                    ? '남자'
                                    : '여자',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              Text(
                                '${userDetailInfo?['birthday'] ?? 0}',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                              Text(
                                '${userDetailInfo?['createAt']?.substring(0, 10) ?? 0}',
                                style: TextStyle(
                                  fontSize: TITLE_FONT_SIZE + 5,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BaseContainer(
                        color: Colors.white,
                        width: 200,
                        height: 50,
                        child: TextButton(
                          onPressed: () async {
                            // 회원정보 수정 페이지로 넘어가기
                            await context
                                .read<UserStore>()
                                .getUserDetailData(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserInfoUpdateScreen()));
                          },
                          child: Text(
                            '정보 변경',
                            style: TextStyle(
                              fontSize: TITLE_FONT_SIZE + 5,
                            ),
                          ),
                        ),
                      ),
                      BaseContainer(
                          color: Colors.white,
                          width: 200,
                          height: 50,
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
                            child: Text(
                              '회원탈퇴',
                              style: TextStyle(
                                fontSize: TITLE_FONT_SIZE + 5,
                              ),
                            ),
                          )),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
