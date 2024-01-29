import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/inventory_screen.dart';
import 'package:yourpilling/screen/main_screen.dart';
import 'package:share/share.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

var pillDetailInfo = [
  {
    'pillName': '트리플 스트렝스 오메가3 피쉬오일 (오메가3 1040mg)', // 영양제 이름
    'manufacturer': '나우푸드', // 제조사
    'expirationAt': '2년', //유효복용기간
    'usageInstructions': '물과 함께 잘 드세요', //복약지도
    'primaryFunctionality': '기력 증진', //주요기능
    'precautions': '약이 상당히 크니 삼킬 때 조심하세요', //주의사항
    'storageInstructions': '상온 보관', //보관방법
    'standardSpecification': '붕해시험 : 적합', //기준규격
    'productForm': '고체형', // 제형
    'takeCount': '1.0', //일일 복용량
    'nutrients': [
      {
        'nutritionId': '',
        'nutrition': '오메가3',
        'amount': '40',
        'unit': 'mg',
        'includePercent': '3.33',
      } //사람마다 등록한 날이 다를텐데 userId없어도 되는지? createAt, updateAt 관련.
    ]
  },
];

class PillDetailScreen extends StatefulWidget {
  const PillDetailScreen({super.key});

  @override
  State<PillDetailScreen> createState() => _pillDetailScreenState();
}

class _pillDetailScreenState extends State<PillDetailScreen> {
  final _scrollController = ScrollController();
  double scrollOpacity = 0;

  //스크롤에 따른 투명도 계산
  onScroll() {
    setState(() {
      double offset = _scrollController.offset;
      if (offset < 0) {
        offset = 0;
      } else if (offset > 100) {
        offset = 100;
      }
      scrollOpacity = offset / 100;
    });
  }

  //나타나는 과정
  @override
  void initState() {
    _scrollController.addListener(onScroll);
    super.initState();
  }

  //사라지는 과정
  @override
  void dispose() {
    _scrollController.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var containerWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: RefreshIndicator(
          child: CustomScrollView(
            physics: RangeMaintainingScrollPhysics(),
            controller: _scrollController,
            scrollBehavior: NoBehavior(),
            slivers: <Widget>[
              SliverAppBar(
                leading: IconButton(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: 24,
                  disabledColor: Colors.black,
                ),
                pinned: true,
                elevation: 0,
                bottom: PreferredSize(
                  child: Opacity(
                    opacity: scrollOpacity,
                    child: Container(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  preferredSize: Size.fromHeight(0),
                ),
                backgroundColor: Colors.white.withOpacity(scrollOpacity),
                title: Opacity(
                  opacity: scrollOpacity,
                  child: Container(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                            child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          strutStyle: StrutStyle(fontSize: 16),
                          text: TextSpan(
                            text: '${pillDetailInfo[0]['pillName']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                // actions: <Widget>[
                //   Center(
                //     child: Text(
                //       "QR 체크인",
                //     ),
                //   ),
                //   SizedBox(
                //     width: 12,
                //   ),
                // ],
              ),
              // SliverToBoxAdapter(
              //   child: "",
              // ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Center(
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
                                SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      onPressed: () {
                                        //String content = 'kakao 로 공유!!';
                                      },
                                      icon: Icon(
                                        Icons.share_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
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
                            Container(
                              alignment: Alignment.center,
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
                            Container(
                              width: 300,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: RichText(
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    strutStyle: StrutStyle(fontSize: 16),
                                    text: TextSpan(
                                      text: '${pillDetailInfo[0]['pillName']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image(image: AssetImage('assets/image/비타민B.jpg')),
                    Image(image: AssetImage('assets/image/비타민B.jpg')),
                    Image(image: AssetImage('assets/image/비타민B.jpg')),
                    Image(image: AssetImage('assets/image/비타민B.jpg')),
                  ],
                ),
              ),
            ],
          ),
          onRefresh: () => Future.value(true)),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     const SliverAppBar(
      //       pinned: true,
      //       snap : false,
      //       floating: false,
      //       expandedHeight: 160.0,
      //       backgroundColor: Colors.pinkAccent,
      //       flexibleSpace: const FlexibleSpaceBar(
      //         title: Text('SliverAppBar'),
      //       ),
      //     ),
      //     const SliverToBoxAdapter(
      //       child: SizedBox(
      //         height: 20,
      //         child: Center(
      //           child: Text(''),
      //         ),
      //       ),
      //     )
      //   ],
      //   child: Center(
      //     child: Container(
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(30),
      //         color: Colors.white,
      //       ),
      //       width: containerWidth,
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               SizedBox(
      //                 width: 30,
      //               ),
      //               Row(
      //                 children: [
      //                   IconButton(
      //                     padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
      //                     onPressed: () {
      //                       // String content = 'kakao로 공유슝!';
      //                     },
      //                     icon: Icon(Icons.share_outlined, size: 30),
      //                   ),
      //                   SizedBox(
      //                     width: 30,
      //                   )
      //                 ],
      //               ),
      //             ],
      //           ),
      //           Container(
      //             alignment: Alignment.center,
      //             padding: const EdgeInsets.all(15),
      //             width: MediaQuery.of(context).size.width,
      //             child: Image.asset(
      //               fit: BoxFit.cover,
      //               'assets/image/비타민B.jpg',
      //             ),
      //           ),
      //           Container(
      //             padding: const EdgeInsets.fromLTRB(10, 40, 0, 20),
      //             child: Text(
      //               // widget.manufacturer,
      //               '${pillDetailInfo[0]['manufacturer']}',
      //               textScaleFactor: 1.3,
      //               style: const TextStyle(
      //                 fontSize: 15,
      //                 fontWeight: FontWeight.w300,
      //               ),
      //             ),
      //           ),
      //           Container(
      //             width: 300,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Flexible(
      //                     child: RichText(
      //                   overflow: TextOverflow.ellipsis,
      //                   maxLines: 2,
      //                   strutStyle: StrutStyle(fontSize: 16),
      //                   text: TextSpan(
      //                     text: '${pillDetailInfo[0]['pillName']}',
      //                     style: const TextStyle(
      //                       fontSize: 20,
      //                       fontWeight: FontWeight.bold,
      //                     ),
      //                   ),
      //                 )),
      //               ],
      //             ),
      //           ),
      //           ////////////
      //           Container(
      //             width: 300,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Flexible(
      //                     child: RichText(
      //                       overflow: TextOverflow.ellipsis,
      //                       maxLines: 2,
      //                       strutStyle: StrutStyle(fontSize: 16),
      //                       text: TextSpan(
      //                         text: '${pillDetailInfo[0]['pillName']}',
      //                         style: const TextStyle(
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                     )),
      //               ],
      //             ),
      //           ),Container(
      //             width: 300,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Flexible(
      //                     child: RichText(
      //                       overflow: TextOverflow.ellipsis,
      //                       maxLines: 2,
      //                       strutStyle: StrutStyle(fontSize: 16),
      //                       text: TextSpan(
      //                         text: '${pillDetailInfo[0]['pillName']}',
      //                         style: const TextStyle(
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                     )),
      //               ],
      //             ),
      //           ),Container(
      //             width: 300,
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 Flexible(
      //                     child: RichText(
      //                       overflow: TextOverflow.ellipsis,
      //                       maxLines: 2,
      //                       strutStyle: StrutStyle(fontSize: 16),
      //                       text: TextSpan(
      //                         text: '${pillDetailInfo[0]['pillName']}',
      //                         style: const TextStyle(
      //                           fontSize: 20,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                     )),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
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

  void onRefresh() {}
}

class NoBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
