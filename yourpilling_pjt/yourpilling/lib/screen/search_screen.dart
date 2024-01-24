import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_health_screen.dart';
import 'package:yourpilling/screen/search_nutrient_screen.dart';
import '../component/BaseContainer.dart';

class SearchScreen extends StatefulWidget {

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20 , vertical: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  // TextField 위젯을 추가합니다.
                  Expanded(
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        labelText: 'Enter text',
                      ),
                    ),
                  ),
                  Icon(Icons.search, color: Color(0xFFFF6666)),
                ],
              ),
            ), 
            BaseContainer(
              width: 350,
              height: 50,
              child: TextButton(
                onPressed: () {
                  // TextField에 입력된 텍스트를 출력합니다.
                  print(myController.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchNutrientScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("성분으로 검색하기?", style: TextStyle(
                      color: LIGHT_BLACK,
                    )),
                    Icon(Icons.search, color: Color(0xFFFF6666)),
                  ],
                ),
              ),
            ),
            BaseContainer(
              width: 350,
              height: 50,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchHealthScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("건강고민으로 검색하기", style: TextStyle(
                      color: LIGHT_BLACK,
                    )),
                    Icon(Icons.search, color: Color(0xFFFF6666)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
