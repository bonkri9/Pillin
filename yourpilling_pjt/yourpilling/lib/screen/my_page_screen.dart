
import 'package:flutter/material.dart';
import 'package:yourpilling/component/AngleContainer.dart';
import 'package:yourpilling/component/app_bar_search.dart';
import 'package:yourpilling/const/colors.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});
// todo : 상단바 위젯 스크롤 내리면 사라지고 올리면 뜨게 하기
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MainAppBarSearch(barColor: Colors.white),
      body: ListView(
        children: [
          AngleContainer(
              width: 300,
              height : 190,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                    SizedBox(width: double.infinity, height: 20,),
                    Text("성현님", style: TextStyle(
                      color: HOT_PINK,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    )),
                    Text("오늘도 건강하세요!", style: TextStyle(
                      color: LIGHT_BLACK,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                    ),
                    Container(
                      height: 30,
                      child: TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          padding: MaterialStateProperty.all(EdgeInsets.zero), // 버튼의 기본 패딩 없애기
                        ),
                        onPressed: () {},
                        child: Text("정보 수정", style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          // 설정 관리
          AngleContainer(
              width: 300,
              height : 200,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text("설정 관리", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: LIGHT_BLACK,
                ),),
              )),

          // 고객 지원
          AngleContainer(
              width: 300,
              height : 300,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text("고객 지원", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: LIGHT_BLACK,
                ),),
              )),
        ],
      )
    );
  }
}
