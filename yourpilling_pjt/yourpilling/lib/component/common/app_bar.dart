import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yourpilling/screen/Login/login_screen.dart';
import 'package:yourpilling/screen/Mypage/my_page_screen.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({Key? key, this.barColor}) : super(key: key);

  var barColor; // 상단바 색상

  @override
  _MainAppBarState createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: widget.barColor,
      toolbarHeight: 120,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/logo/only_pillin_logo.png',
                  width: 70, height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // 로그아웃 기능
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      CupertinoIcons.arrowshape_turn_up_left,
                      size: 30,
                    ),
                    onPressed: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (BuildContext context) => CupertinoAlertDialog(
                          title: const Text('알림'),
                          content: const Text('로그아웃하시겠습니까?'),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: const Text('아니오'),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () async {
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                await prefs.remove('token');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) => LoginScreen(),
                                  ),
                                );
                              },
                              child: Text('예'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // IconButton(
                  //   padding: EdgeInsets.only(right: 15),
                  //   visualDensity: const VisualDensity(horizontal: -4),
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.search,
                  //     size: 28,
                  //   ),
                  // ),
                  // IconButton(
                  //   padding: EdgeInsets.only(right: 15),
                  //   visualDensity: const VisualDensity(horizontal: -4),
                  //   onPressed: () {},
                  //   icon: Row(
                  //     children: [
                  //       SvgPicture.asset('assets/icon/bell.svg',
                  //           width: 26, height: 26, color: BASIC_BLACK,),
                  //       // 알람 아이콘 크기
                  //     ],
                  //   ),
                  // ),
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   visualDensity: const VisualDensity(horizontal: -4),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => MyPage())); // 마이페이지로 이동
                  //   },
                  //   icon: Row(
                  //     children: [
                  //       SvgPicture.asset('assets/icon/user.svg',
                  //           width: 28, height: 28),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
