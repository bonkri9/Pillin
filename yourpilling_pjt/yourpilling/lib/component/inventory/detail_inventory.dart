import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:http/http.dart' as http;
import '../../store/inventory_store.dart';
import '../../store/user_store.dart';
import '../inventory/insert_inventory.dart';

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
    'takecycle': '1', //1일
    'takeCount': '1', //1회
    'takeOnceAmount': '2', //2정
    'createdAt': '',
    'updatedAt': '2024-01-29', //제품 정보 수정날짜
    'nutrients': [
      {
        'nutrition': '오메가3',
        'amount': '40',
        'unit': 'mg',
        'includePercent': '3.33',
      } //사람마다 등록한 날이 다를텐데 userId없어도 되는지? createAt, updateAt 관련.
    ]
  },
];

var nutients = [
  {
    'nutrition': '오메가3',
    'amount': '40',
    'unit': 'mg',
    'includePercent': '3.33',
  }
];

// void loadData(BuildContext context) {
//   context.read<InventoryStore>().getPillDetailData(context, ownPillId);
// }

class InvenDetailScreen extends StatefulWidget {
  var ownPillId;

  InvenDetailScreen({super.key, this.ownPillId});

  @override
  State<InvenDetailScreen> createState() => _invenDetailScreenState();
}

class _invenDetailScreenState extends State<InvenDetailScreen> {
  final _scrollController = ScrollController();
  double scrollOpacity = 0;

  // var ownPillId;
  // late String accessToken;
  // final String invenDetailUrl = "http://10.0.2.2:8080/api/v1/pill/inventory";
  //
  // getInvenDetail() async {
  //   print("재고 상세 요청");
  //
  //   // int pillId = 256;
  //   var response = await http.get(
  //       Uri.parse('$invenDetailUrl?ownPillId=256'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'accessToken': accessToken,
  //       },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print("재고 상세 요청 수신 성공");
  //     print(response.body);
  //     var accessToken =
  //         response.headers['accesstoken']; // 이거 Provider 로 전역에 저장해보자
  //     print(accessToken);
  //   } else {
  //     print(response.body);
  //     print("재고 상세 요청 수신 실패");
  //   }
  // }

  // setownPillId(ownPillIdInput) {
  //   ownPillId = ownPillIdInput;
  // }

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
    // context.read<InventoryStore>().getPillDetailData(context, ownPillId);
  }

  //사라지는 과정
  @override
  void dispose() {
    _scrollController.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // accessToken = context.watch<UserStore>().accessToken;
    var ownPillId = widget.ownPillId;
    void loadData(BuildContext context) {
      context.read<InventoryStore>().getPillDetailData(context, ownPillId);
    }

    loadData(context);
    var invenDetailData = context.read<InventoryStore>().invenDetailData;
    var containerWidth = MediaQuery.of(context).size.width * 0.9;
    print(invenDetailData);
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
                  preferredSize: Size.fromHeight(0),
                  child: Opacity(
                    opacity: scrollOpacity,
                    child: Container(
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ),
                backgroundColor: Colors.white.withOpacity(scrollOpacity),
                title: Opacity(
                  opacity: scrollOpacity,
                  child: Container(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 300,
                            child: RichText(
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              strutStyle: StrutStyle(fontSize: 16),
                              text: TextSpan(
                                text: '${invenDetailData['pill']['name']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
                                Text('재고 상세 페이지'),
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
                              child: Image.network(
                                fit: BoxFit.cover,
                                '${invenDetailData['pill']['imageUrl']}',
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
                                width: 270,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  strutStyle: StrutStyle(fontSize: 16),
                                  text: TextSpan(
                                    text: '${invenDetailData['pill']['name']}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                            Divider(
                              height: 50,
                              indent: 50,
                              endIndent: 50,
                            ),
                            Center(
                              child: Column(
                                children: [
                                  Text('복용 루틴 정보'),
                                  PillRoutineInfo(),
                                  Divider(
                                    height: 50,
                                    indent: 50,
                                    endIndent: 50,
                                  ),
                                  Text('영양제 상세 정보'),
                                  PillDetailInfo(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onRefresh: () => Future.value(true)),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('구매하기'),
              onPressed: () async {
                final url = Uri.parse(
                    'https://www.coupang.com/vp/products/7559679373?itemId=20998974266&vendorItemId=70393847077&q=%EB%82%98%EC%9A%B0%ED%91%B8%EB%93%9C+%EC%98%A4%EB%A9%94%EA%B0%803&itemsCount=36&searchId=042c491feb4b4cc699aea94c1b27be04&rank=1&isAddedCart=');
                if (await canLaunchUrl(url)) {
                  launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            )
          ],
        ),
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

class PillDetailInfo extends StatefulWidget {
  var ownPillId;

  PillDetailInfo({super.key, this.ownPillId});

  @override
  State<PillDetailInfo> createState() => _PillDetailInfoState();
}

class _PillDetailInfoState extends State<PillDetailInfo> {
  @override
  Widget build(BuildContext context) {
    var ownPillId = widget.ownPillId;
    void loadData(BuildContext context) {
      context.read<InventoryStore>().getPillDetailData(context, ownPillId);
    }

    loadData(context);
    var invenDetailData = context.read<InventoryStore>().invenDetailData;
    return Column(
      children: [
        //유효 복용 기간
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('유효복용기간 : '),
              Text(
                '${invenDetailData['pill']['expirationAt'] ?? '미정'}',
                style: const TextStyle(
                  color: Colors.black,
                  // fontSize: 15,
                  // fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        //주요 기능
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('주요기능 : '),
              Text(
                '${invenDetailData['pill']['primaryFunctionality'] ?? '미표기'}',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        //주의사항
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('주의사항 : '),
              Text(
                '${invenDetailData['pill']['precautions'] ?? '미표기'}',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        //복약지도
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('복용방법 : '),
              Text(
                '${invenDetailData['pill']['usageInstructions'] ?? '미표기'}',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        //보관 방법
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('보관방법 : '),
              Text(
                '${invenDetailData['pill']['storageInstructions'] ?? '미표기'}',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        //기준 규격
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('기준 규격 : '),
              Text(
                '${invenDetailData['pill']['standardSpecification'] ?? '미표기'}',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        //제형
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('영양제형 : '),
              Text(
                '${invenDetailData['pill']['productForm'] ?? '미표기'}',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//영양소 정보
class PillRoutineInfo extends StatefulWidget {
  var ownPillId;

  PillRoutineInfo({super.key, this.ownPillId});

  @override
  State<PillRoutineInfo> createState() => _PillRoutineInfoState();
}

class _PillRoutineInfoState extends State<PillRoutineInfo> {
  @override
  Widget build(BuildContext context) {
    var ownPillId = widget.ownPillId;
    void loadData(BuildContext context) {
      context.read<InventoryStore>().getPillDetailData(context, ownPillId);
    }

    loadData(context);
    var invenDetailData = context.read<InventoryStore>().invenDetailData;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('재고량 : '),
              Text(
                '${invenDetailData['remains']} 정 / ${invenDetailData['totalCount']} 정',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('일일 복용 횟수 : '),
              Text(
                '${invenDetailData['takeCount']} 회',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('1회 복용량 : '),
              Text(
                '${invenDetailData['takeOnceAmount']} 정',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text('복용시작일 : '),
              Text(
                '${invenDetailData['startAt'] ?? '미정'}',
                // style: const TextStyle(
                //   fontSize: 15,
                //   fontWeight: FontWeight.w300,
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
