
import 'package:flutter/material.dart';
import 'package:yourpilling/screen/alarm_screen.dart';
import 'package:yourpilling/screen/inventory_screen.dart';
import 'search_screen.dart';
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
    SearchScreen(),
    Inventory(),
    AlarmScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainTabs[curTabIdx],
      bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.home_outlined, color: Color(0xFFD3D3D3)),
              activeIcon: Icon(Icons.home_filled, color: Color(0xFFFF6666))
          ),
          BottomNavigationBarItem(
              label: '검색',
              icon: Icon(Icons.search_outlined, color: Color(0xFFD3D3D3)),
              activeIcon: Icon(Icons.search, color: Color(0xFFFF6666)),
          ),
          BottomNavigationBarItem(
            label: '재고',
            icon: Icon(Icons.shopping_cart_outlined, color: Color(0xFFD3D3D3)),
            activeIcon: Icon(Icons.shopping_cart, color: Color(0xFFFF6666)),
          ),
          BottomNavigationBarItem(
              label: '알람',
              icon: Icon(Icons.alarm_outlined, color: Color(0xFFD3D3D3)),
              activeIcon: Icon(Icons.alarm, color: Color(0xFFFF6666)),
          ),
        ],
      ),

    );
  }
}
