import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import '../component/base_container.dart';

class SearchHealthScreen extends StatefulWidget {

  const SearchHealthScreen({super.key});

  @override
  State<SearchHealthScreen> createState() => _SearchHealthScreenState();
}

class _SearchHealthScreenState extends State<SearchHealthScreen> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchHealthScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("눈 건강", style: TextStyle(
                      color: BASIC_BLACK,
                    )),
                    Text("피로 개선", style: TextStyle(
                      color: BASIC_BLACK,
                    )),
                    Text("장 건강", style: TextStyle(
                      color: BASIC_BLACK,
                    )),
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
