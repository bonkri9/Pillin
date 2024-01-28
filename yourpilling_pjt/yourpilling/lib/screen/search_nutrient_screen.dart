import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import '../component/base_container.dart';

class SearchNutrientScreen extends StatefulWidget {

  const SearchNutrientScreen({super.key});

  @override
  State<SearchNutrientScreen> createState() => _SearchNutrientScreenState();
}

class _SearchNutrientScreenState extends State<SearchNutrientScreen> {
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
                    Text("마그네슘", style: TextStyle(
                      color: BASIC_BLACK,
                    )),
                    Text("오메가3", style: TextStyle(
                      color: BASIC_BLACK,
                    )),
                    Text("비타민C", style: TextStyle(
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
