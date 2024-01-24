import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';

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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "YourPilling",
            style: TextStyle(
              fontSize: 14,
              color: BASIC_BLACK,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Row(
                  children: [
                    Icon(Icons.notifications_outlined, size: 20, color: BASIC_BLACK,),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Row(
                  children: [
                    Icon(Icons.person_outline, size: 20, color: BASIC_BLACK,),
                  ],
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}



