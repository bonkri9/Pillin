import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/inventory_screen.dart';
import 'package:yourpilling/screen/main_screen.dart';
import 'package:share/share.dart';

var pillDetailInfo = [
  {
    'pillName': '오메가-3', // 영양제 이름
    'manufacturer': '나우푸드', // 제조사
    'productForm': '고체형', // 제형
  },
];

class PillDetailScreen extends StatefulWidget {
  const PillDetailScreen({super.key});

  // String pillName;
  // String manufacturer;
  // String productForm;
  //
  // PillDetailScreen({
  //   super.key,
  //   required this.pillName,
  //   required this.manufacturer,
  //   required this.productForm,
  // });

  @override
  State<PillDetailScreen> createState() => _pillDetailScreenState();
}

class _pillDetailScreenState extends State<PillDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var containerWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        title: const Text("영양제 상세 페이지"),
        centerTitle: true,
      ),
      backgroundColor: BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            width: containerWidth,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 30, 20, 20),
                          child: Text(
                            // widget.pillName,
                            '${pillDetailInfo[0]['pillName']}',
                            textScaleFactor: 1.5,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 40, 0, 20),
                          child: Text(
                            // widget.manufacturer,
                            '${pillDetailInfo[0]['manufacturer']}',
                            textScaleFactor: 1.3,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          onPressed: () {
                            // String content = 'kakao로 공유슝!';
                          },
                          icon: Icon(Icons.share_outlined, size: 30),
                        ),
                        SizedBox(
                          width: 30,
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    fit: BoxFit.cover,
                    'assets/image/비타민B.jpg',
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BACKGROUND_COLOR,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: '등록하기',
            icon: ElevatedButton(
              child: Text('등록하기'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Inventory()));
                //   builder:(context) => InsertInventory()));
              },
            ),
          ),
          BottomNavigationBarItem(
            label: '구매하기',
            icon: ElevatedButton(
              child: const Text('구매하기'),
              onPressed: () async {
                final url = Uri.parse(
                    'https://www.coupang.com/vp/products/7559679373?itemId=20998974266&vendorItemId=70393847077&q=%EB%82%98%EC%9A%B0%ED%91%B8%EB%93%9C+%EC%98%A4%EB%A9%94%EA%B0%803&itemsCount=36&searchId=042c491feb4b4cc699aea94c1b27be04&rank=1&isAddedCart=');
                if (await canLaunchUrl(url)) {
                  launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
