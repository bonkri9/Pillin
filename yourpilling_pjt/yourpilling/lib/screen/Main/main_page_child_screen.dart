import 'package:flutter/material.dart';
import 'package:yourpilling/screen/Alarm/alarm_screen.dart';
import 'package:yourpilling/screen/Inventory/inventory_screen.dart';
import 'package:yourpilling/screen/Mypage/my_page_screen.dart';
import '../../const/colors.dart';
import '../Search/search_screen.dart';
import 'main_screen.dart';

class MainPageChild extends StatefulWidget {
  const MainPageChild({super.key});

  @override
  State<MainPageChild> createState() => _MyAppState();
}

class _MyAppState extends State<MainPageChild> {
  var curTabIdx = 0;

  final mainTabs = [
    MainScreen(),
    SearchScreen(showAppBar:false),
    InventoryScreen(),
    AlarmScreen(),
    MyPageScreen(),
  ];


  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        content: Text(
          "한 번 더 누르면 앱이 종료돼요",
          textAlign: TextAlign.center,
          style: TextStyle(color: BASIC_BLACK),
        ),
        backgroundColor: Colors.yellow,
        duration: Duration(milliseconds: 1100),
      ));
      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainTabs[curTabIdx],
      bottomNavigationBar: WillPopScope(
        onWillPop: onWillPop,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(color: Color(0xFFFF6666)),
          unselectedLabelStyle: TextStyle(color: Color(0xFFD3D3D3)),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: curTabIdx,
          onTap: (i) {
            setState(() {
              print(i);
              curTabIdx = i;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: '홈',
                backgroundColor: Colors.white,
                icon: Icon(Icons.home_outlined, color: Color(0xFFD3D3D3)),
                activeIcon: Icon(Icons.home_filled, color: Color(0xFFFF6666))),
            BottomNavigationBarItem(
              label: '검색',
              backgroundColor: Colors.white,
              icon: Icon(Icons.search_outlined, color: Color(0xFFD3D3D3)),
              activeIcon: Icon(Icons.search, color: Color(0xFFFF6666)),
            ),
            BottomNavigationBarItem(
              label: '재고',
              backgroundColor: Colors.white,
              icon: Icon(Icons.shopping_cart_outlined, color: Color(0xFFD3D3D3)),
              activeIcon: Icon(Icons.shopping_cart, color: Color(0xFFFF6666)),
            ),
            BottomNavigationBarItem(
              label: '알람',
              backgroundColor: Colors.white,
              icon: Icon(Icons.alarm_outlined, color: Color(0xFFD3D3D3)),
              activeIcon: Icon(Icons.alarm, color: Color(0xFFFF6666)),
            ),
            BottomNavigationBarItem(
              label: '마이페이지',
              backgroundColor: Colors.white,
              icon: Icon(Icons.person_outline, color: Color(0xFFD3D3D3)),
              activeIcon: Icon(Icons.person, color: Color(0xFFFF6666)),
            ),
          ],
        ),
      ),
    );
  }
}
