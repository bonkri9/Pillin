import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yourpilling/screen/my_page_screen.dart';

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
                  // IconButton(
                  //   padding: EdgeInsets.only(right: 15),
                  //   visualDensity: const VisualDensity(horizontal: -4),
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.search,
                  //     size: 28,
                  //   ),
                  // ),
                  IconButton(
                    padding: EdgeInsets.only(right: 15),
                    visualDensity: const VisualDensity(horizontal: -4),
                    onPressed: () {},
                    icon: Row(
                      children: [
                        SvgPicture.asset('assets/icon/bell.svg',
                            width: 26, height: 26, color: BASIC_BLACK,),
                        // 알람 아이콘 크기
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPage())); // 마이페이지로 이동
                    },
                    icon: Row(
                      children: [
                        SvgPicture.asset('assets/icon/user.svg',
                            width: 28, height: 28),
                      ],
                    ),
                  ),
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
