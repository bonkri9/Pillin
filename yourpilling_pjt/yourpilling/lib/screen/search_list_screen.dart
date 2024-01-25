import 'package:flutter/material.dart';
import 'package:yourpilling/component/BaseContainer.dart';

class SearchListScreen extends StatelessWidget {
  const SearchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
          children: [
            SizedBox(height: 100,),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical, // horizontal은 가로로 정렬
                  shrinkWrap: true,
                  itemCount: 3, // 홈 화면에는 3개까지만 보여주자
                  itemBuilder: (context, i) {
                    return _SearchList();
                  }
              ),
            ),
          ],
        )
    );

  }
}


// 영양제 컴포넌트 하나, 매개변수로 담으면 될듯..?
class _SearchList extends StatelessWidget {
  const _SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: 350,
      height: 200,
      child: Row(
        children: [
          Column(
            children: [
              Text("제조사명", style: TextStyle(
                fontSize: 10,
                color: Colors.blue,
              ),),
              Text("영양제명", style: TextStyle(
                fontSize: 10,
                color: Colors.blue,
              ),),
              Image.asset("assets/image/비타민B.jpg", width: 220, height: 160,),
            ],
          ),
          Column(
            children: [
              Text("비타민B 50mg 함유", style: TextStyle(
                fontSize: 10,
                color: Colors.blue,
              ),),
              Text("마그네슘 125mg 함유", style: TextStyle(
                fontSize: 13,
                color: Colors.green,
              ),),
            ],
          ),

        ],
      ),
    );
  }
}
