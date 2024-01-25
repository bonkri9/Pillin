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
  Size get preferredSize => Size.fromHeight(45);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 45,
      backgroundColor: widget.barColor,
      title: Column(
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/logo/only_pillin_logo.png', width: 55, height: 55),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4),
                    onPressed: () {},
                    icon: Row(
                      children: [
                        SvgPicture.asset('assets/icon/bell.svg', width: 17, height: 17),
                      ],
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(horizontal: -4),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => MyPage()));
                    },
                      icon: Row(
                        children: [
                          SvgPicture.asset('assets/icon/user.svg', width: 17, height: 17),
                        ],
                    ),
                  ),
                  SizedBox(width: 15,)
                ],
              ),

            ],
          ),
          SizedBox(height: 8,),
        ],
      ),
    );
  }
}



