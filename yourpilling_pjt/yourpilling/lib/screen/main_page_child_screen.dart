
import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'menu_screen.dart';
import 'my_page_screen.dart';

class MainPageChild extends StatefulWidget {
  const MainPageChild({super.key});

  @override
  State<MainPageChild> createState() => _MyAppState();
}

class _MyAppState extends State<MainPageChild> {
  var curTabIdx = 1;

  final mainTabs = [
    Menu(),
    MainScreen(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainTabs[curTabIdx],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: curTabIdx,
        onTap: (i) {
          setState(() {
            print(i);
            curTabIdx = i;
          });
        },
        items: [
          BottomNavigationBarItem(
              label: '내 영양제',
              icon: Icon(Icons.medical_information_outlined),
              activeIcon: Icon(Icons.medical_information, color: Color(0xFFFF6666))
          ),
          BottomNavigationBarItem(
              label: '홈',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_filled, color: Color(0xFFFF6666))
          ),
          BottomNavigationBarItem(
            label: '마이페이지',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person, color: Color(0xFFFF6666)),
          ),
        ],
      ),

    );
  }
}
