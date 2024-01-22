import 'package:flutter/material.dart';

class PillDetailScreen extends StatelessWidget {
  const PillDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('영양제 상세 페이지'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 공유하기 버튼
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // 공유 기능 구현
                },
                child: Text('공유하기'),
              ),
            ),

            // 영양제 사진
            // Image.network('https://img.danawa.com/prod_img/500000/574/219/img/4219574_1.jpg?_v=20230609105131'),
            Image.asset('asset/img/sampleImg.jpg',),

            // 영양제 제조사
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('영양제 제조사: 제조사명'),
            ),

            // 영양제 이름
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('영양제 이름: 영양제명'),
            ),

            // 해당 영양제 랭킹
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('영양제 랭킹: 1위'),
            ),

            // 영양제 성분
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('영양제 성분: 성분 내용'),
            ),
          ],

        ),
      ),
      bottomNavigationBar:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 구매하기
            ElevatedButton(
              onPressed: () {
                // 구매 기능 구현
              },
              child: Text('등록하기'),
            ),

            // 등록하기
            ElevatedButton(
              onPressed: () {
                // 등록 기능 구현
              },
              child: Text('구매하기'),
            ),
          ],
        ),
    );
  }
}
