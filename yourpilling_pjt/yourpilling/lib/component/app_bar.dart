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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, size: 22,),
          ),
        ],
      ),
    );
  }
}
