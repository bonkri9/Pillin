import 'package:flutter/material.dart';
import 'package:yourpilling/screen/Search/search_screen.dart';

class MainAppBarSearch extends StatefulWidget implements PreferredSizeWidget {
  MainAppBarSearch({Key? key, this.barColor}) : super(key: key);

  var barColor; // 상단바 색상

  @override
  _MainAppBarSearchState createState() => _MainAppBarSearchState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _MainAppBarSearchState extends State<MainAppBarSearch> {
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
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(showAppBar: false,)));
                },
                icon: Icon(Icons.search, size: 22,),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
