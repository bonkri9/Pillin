import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_health_screen.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
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

  _SearchScreenState() {
    myController.addListener(() {
      print("TextField content: ${myController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 터치하면 키보드꺼짐
      },
      child: Scaffold(
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SearchBar(myController: myController,),
            _MiddleTap(),
            _Ranking(),
            // 랭킹페이지
          ],
        ),
      ),
    );

  }
}



// 검색바
class _SearchBar extends StatelessWidget {
  final TextEditingController myController;

  const _SearchBar({Key? key, required this.myController}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // TextField 위젯을 추가합니다.
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: '검색어를 입력하세요',
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.search, color: Color(0xFFFF6666)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchListScreen()));
              }),
        ],
      ),
    );
  }
}



// 성분 검색, 건강 검색
class _MiddleTap extends StatelessWidget {
  const _MiddleTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20,),
        BaseContainer(
          width: 180,
          height: 180,
          child: TextButton(
            onPressed: () {
              // TextField에 입력된 텍스트를 출력합니다.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchNutrientScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("성분검색",
                    style:
                    TextStyle(color: LIGHT_BLACK, fontSize: 30)),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        BaseContainer(
          width: 180,
          height: 180,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchHealthScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("건강 검색",
                    style:
                    TextStyle(color: LIGHT_BLACK, fontSize: 30)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 랭킹페이지
class _Ranking extends StatelessWidget {
  const _Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseContainer(
        width: 350,
        height: 500,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("영양제 랭킹", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30.5,
                    color: BASIC_BLACK,
                  ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Inventory()));
                    },
                    icon: Icon(Icons.arrow_forward_ios, size: 15,),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 3, // 홈 화면에는 3개까지만 보여주자
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Image.asset("assets/image/비타민B.jpg", width: 110, height: 80,),
                        SizedBox(height: 6),
                        Text("비타민B", style: TextStyle(
                          fontSize: 10,
                          color: BASIC_BLACK,
                        ),),
                        Text("49/50", style: TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                        ),),

                      ],
                    );
                  }
              ),
            )
          ],
        )
    );
  }
}