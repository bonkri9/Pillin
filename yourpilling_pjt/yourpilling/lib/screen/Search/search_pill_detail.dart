import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yourpilling/const/colors.dart';
import '../Inventory/insert_inventory.dart';
import '../../store/search_store.dart';

// var nutients = [
//   {
//     'nutrition': '오메가3',
//     'amount': '40',
//     'unit': 'mg',
//     'includePercent': '3.33',
//   }
// ];

class PillDetailScreen extends StatefulWidget {
  var pillId;

  PillDetailScreen({super.key, this.pillId});

  @override
  State<PillDetailScreen> createState() => _pillDetailScreenState();
}

class _pillDetailScreenState extends State<PillDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var pillId = widget.pillId;
    void loadData(BuildContext context) {
      context.read<SearchStore>().getSearchDetailData(context, pillId);
    }

    loadData(context);
    return info();
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

class info extends StatefulWidget {
  const info({super.key});

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  final _scrollController = ScrollController();
  double scrollOpacity = 0;
  bool scrollToggle = true;
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

  toggleBottomBar() {
    setState(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        scrollToggle = true;
      } else {
        scrollToggle = false;
      }
    });
  }



  //나타나는 과정
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);
    _scrollController.addListener(toggleBottomBar);
  }

  //사라지는 과정
  @override
  void dispose() {
    _scrollController.removeListener(onScroll);
    _scrollController.removeListener(toggleBottomBar);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pillDetailInfo = context.watch<SearchStore>().pillDetailData;

    var containerWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      backgroundColor: Colors.yellow,
      body: CustomScrollView(
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
                  width: 300,
                  child: RichText(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    strutStyle: StrutStyle(fontSize: 16),
                    text: TextSpan(
                      text: '${pillDetailInfo['pillName']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x00b5b5b5).withOpacity(0.3),
                            offset: Offset(0.1, 0.1),
                            blurRadius: 4 // 그림자 위치 조정
                            ),
                      ],
                      color: Colors.white,
                    ),
                    width: containerWidth,
                    height: 550,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(50),
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              fit: BoxFit.cover,
                              '${pillDetailInfo['imageUrl']}',
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${pillDetailInfo['manufacturer']}',
                              style: TextStyle(
                                fontFamily: "Pretendard",
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: BASIC_BLACK.withOpacity(0.3),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                              width: 300,
                              child: RichText(
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                strutStyle: StrutStyle(fontSize: 16),
                                text: TextSpan(
                                  text: '${pillDetailInfo['pillName']}',
                                  style: TextStyle(
                                    fontFamily: "Pretendard",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: BASIC_BLACK.withOpacity(0.8),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 45,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/image/health-mark.png",
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '건강기능식품',
                                  style: TextStyle(
                                    fontFamily: "Pretendard",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: BASIC_BLACK.withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                Container(
                  // 화면 크기의 컨테이너
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0.1, 0.1),
                            blurRadius: 4 // 그림자 위치 조정
                            ),
                      ]),
                  child: Center(
                      child: Column(
                    children: [
                      PillDetailInfo(),
                    ],
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
      // 하단 바
      bottomNavigationBar: scrollToggle ? BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: '등록하기',
            icon: GestureDetector(
              onTap: () {
                var pillId = pillDetailInfo['pillId'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InsertInventory(
                              pillId: pillId,
                            )));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),

                child: Text(
                  '내 영양제 등록하기',
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    color: BASIC_BLACK.withOpacity(0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: '영양제 구매하기',
            icon: GestureDetector(
              onTap: () {
                var pillName = pillDetailInfo['pillName'];
                context.read<SearchRepository>().getNaverBlogSearch(pillName);
                var buyLink = context.read<SearchRepository>().BuyLink; // 네이버 구매 링크
                print(buyLink);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Text(
                  '구매하러 가기',
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    color: BASIC_BLACK.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ),
            ),
          ),
        ],
      ) : null,
    );
  }
}

class PillDetailInfo extends StatefulWidget {
  var pillId;

  PillDetailInfo({super.key, this.pillId});

  @override
  State<PillDetailInfo> createState() => _PillDetailInfoState();
}

class _PillDetailInfoState extends State<PillDetailInfo> {
  @override
  Widget build(BuildContext context) {
    var pillDetailInfo = context.watch<SearchStore>().pillDetailData;
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "유효 복용 기간",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          //유효 복용 기간
          Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                '- ${pillDetailInfo['expirationAt'] ?? '미정'}',
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),

          // 주요 기능
          Text(
            "주요 기능",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '${pillDetailInfo['primaryFunctionality'] ?? '미표기'}',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),

          //주의사항
          Text(
            "주의 사항",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '${pillDetailInfo['precautions'] ?? '미표기'}',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          //복약지도
          Text(
            "복용 방법",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '- ${pillDetailInfo['usageInstructions'] ?? '미표기'}',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),
          //보관 방법

          Text(
            "보관 방법",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '${pillDetailInfo['storageInstructions'] ?? '미표기'}',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),
          //기준 규격
          Text(
            "기준 규격",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '${pillDetailInfo['standardSpecification'] ?? '미표기'}',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),
          //제형
          Text(
            "영양제형",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '- ${pillDetailInfo['productForm'] ?? '미표기'}',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),
          // 복용 주기
          Text(
            "복용 주기",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '- ${pillDetailInfo['takeCycle']} 일',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),
          // 일일 복용 횟수
          Text(
            "일일 복용 횟수",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Text(
              '- ${pillDetailInfo['takeCount']} 회',
              style: const TextStyle(
                fontFamily: "Pretendard",
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          SizedBox(
            height: 50,
          ),
          // 1회 복용량
          Text(
            "1회 복용량",
            style: TextStyle(
              fontFamily: "Pretendard",
              color: BASIC_BLACK, // 영양이 부분의 색상을 빨간색으로 지정
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 30),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  '- ${pillDetailInfo['takeOnceAmount']} 정',
                  style: const TextStyle(
                    fontFamily: "Pretendard",
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

//영양소 정보
class PillNutrientInfo extends StatefulWidget {
  var pillId;

  PillNutrientInfo({super.key, this.pillId});

  @override
  State<PillNutrientInfo> createState() => _PillNutrientInfoState();
}

class _PillNutrientInfoState extends State<PillNutrientInfo> {
  @override
  Widget build(BuildContext context) {
    var pillDetailInfo = context.read<SearchStore>().pillDetailData;
    // print(pillDetailInfo);
    var nutrientsList = pillDetailInfo['nutrients']['nutrientsItems'];
    var listLength = nutrientsList.length ?? 0;
    // print(listLength);

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listLength ?? 0,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 30),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text('영양소명 : '),
                    Text(
                      '${nutrientsList[i]['nutrition']}',
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
                    Text('함량 : '),
                    Text(
                      '${nutrientsList[i]['amount']} ${nutrientsList[i]['unit']}',
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
                    Text('함유율(%) : '),
                    Text(
                      '${nutrientsList[i]['includePercent'] ?? '미표기'} ',
                      // style: const TextStyle(
                      //   fontSize: 15,
                      //   fontWeight: FontWeight.w300,
                      // ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 50,
                indent: 50,
                endIndent: 50,
              ),
            ],
          );
        });
  }
}
