import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/inventory_screen.dart';
import 'package:yourpilling/screen/main_screen.dart';

class PillDetailScreen extends StatefulWidget {
  const PillDetailScreen({super.key});

  // int pillNo;
  // String pillName;
  // String pillImgUrl;
  // int rank;
  //
  // PillDetailScreen(
  //     {super.key,
  //     required this.pillNo,
  //     required this.pillName,
  //     required this.pillImgUrl,
  //     required this.rank});

  @override
  State<PillDetailScreen> createState() => _PillDetailScreenState();
}

class _PillDetailScreenState extends State<PillDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF5F4),
      appBar: AppBar(
        title: Text('영양제 상세 페이지'),
        centerTitle: true,
        backgroundColor: Color(0xFFFFF5F4),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child:  Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4.0, //shadow
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(60),
                  child: Image(
                      width: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/image/비타민B.jpeg")
                    // imageUrl: widget.productImageUrl,
                    // placeholder: (context, url){
                    //   return const Center(
                    //     child: CircularProgressIndicator(
                    //       strokeWidth: 2,
                    //     ),
                    //   );
                    // },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    // widget.pillName,
                    // textScaleFactor: 1.5,
                    // style: const TextStyle(
                    //   fontWeight: FontWeight.bold,
                    // ),
                    '뉴트리코스트',
                    style: TextStyle(fontWeight: FontWeight.w100),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical:10),
                  child: Text(
                    '비타민B',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

              ],
            ),
          ),

        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFFF5F4),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // '내 영양제 등록하기' 버튼 클릭 시 수행할 작업 추가
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: Text(
                  '내 영양제 등록하기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 16.0), // 간격 조절
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // '구매하러 가기' 버튼 클릭 시 수행할 작업 추가
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: Text(
                  '구매하러 가기',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      // Center(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding:
      //             const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //         child: Column(
      //           children: [
      //             Image.asset(
      //               "assets/image/비타민B.jpeg",
      //               width: 350,
      //               height: 350,
      //             ),
      //             Text('뉴트리코스트'),
      //             Text('비타민B')
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
