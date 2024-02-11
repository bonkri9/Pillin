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
    DateTime now = DateTime.now();
    const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: widget.barColor,
      toolbarHeight: 120,
      elevation: 0,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/logo/only_pillin_logo.png',
              //     width: 70, height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${now.month}.${now.day} ${weekDays[now.weekday - 1]}",
                    style: TextStyle(
                      color: BASIC_BLACK,
                      fontSize: 18,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   visualDensity: const VisualDensity(horizontal: -4),
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => MyPageScreen())); // 마이페이지로 이동
                  //   },
                  //   icon: Row(
                  //     children: [
                  //       SvgPicture.asset('assets/icon/user.svg',
                  //           width: 28, height: 28),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
