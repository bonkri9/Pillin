import 'package:flutter/material.dart';
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

    var pillId = widget.pillId;
    void loadData(BuildContext context) {
      context.read<SearchStore>().getSearchDetailData(context, pillId);
    }

    loadData(context);
    var pillDetailInfo = context.read<SearchStore>().PillDetailData;
    // print(pillDetailInfo);
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
                            fontWeight: FontWeight.bold,
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
                          color: Colors.white,
                        ),
                        width: containerWidth,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text('검색 상세 페이지'),
                                SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  children: [
                                    // IconButton(
                                    //   padding: const EdgeInsets.fromLTRB(
                                    //       10, 10, 10, 10),
                                    //   onPressed: () {
                                    //     //String content = 'kakao 로 공유!!';
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.share_outlined,
                                    //     size: 30,
                                    //   ),
                                    // ),
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
                                '${pillDetailInfo['imageUrl']}',
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                '${pillDetailInfo['manufacturer']}',
                                textScaleFactor: 1.3,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
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
                                  Text('영양제 정보'),
                                  PillDetailInfo(),
                                  Divider(
                                    height: 50,
                                    indent: 50,
                                    endIndent: 50,
                                  ),
                                  Text('영양소 정보'),
                                  PillNutrientInfo(),
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
                var pillId = pillDetailInfo['pillId'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InsertInventory(pillId: pillId,)));
              },
            ),
          ),
          BottomNavigationBarItem(
            label: '구매하기',
            icon: ElevatedButton(
              child: const Text('구매하기'),
              onPressed: () async {
                var pillName = pillDetailInfo['pillName'];
                // final url = Uri.parse(
                //     'https://www.coupang.com/vp/products/7559679373?itemId=20998974266&vendorItemId=70393847077&q=%EB%82%98%EC%9A%B0%ED%91%B8%EB%93%9C+%EC%98%A4%EB%A9%94%EA%B0%803&itemsCount=36&searchId=042c491feb4b4cc699aea94c1b27be04&rank=1&isAddedCart=');
                // if (await canLaunchUrl(url)) {
                //   launchUrl(url, mode: LaunchMode.externalApplication);
                // }

                context.read<SearchRepository>().getNaverBlogSearch(pillName);
                var buyLink = context.read<SearchRepository>().BuyLink;
                print(buyLink);
                print('위에가 네이버 구매링크');
                // final url = Uri.parse(buyLink);
                //     if (await canLaunchUrl(url)) {
                //       launchUrl(url, mode: LaunchMode.externalApplication);
                //     }

                // getNaverBlogSearch(var pillName);
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

class PillDetailInfo extends StatefulWidget {
  var pillId;

  PillDetailInfo({super.key, this.pillId});

  @override
  State<PillDetailInfo> createState() => _PillDetailInfoState();
}

class _PillDetailInfoState extends State<PillDetailInfo> {
  @override
  Widget build(BuildContext context) {
    var pillDetailInfo = context.read<SearchStore>().PillDetailData;
    // print(pillDetailInfo);
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
                '${pillDetailInfo['expirationAt'] ?? '미정'}',
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
                '${pillDetailInfo['primaryFunctionality'] ?? '미표기'}',
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
                '${pillDetailInfo['precautions'] ?? '미표기'}',
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
                '${pillDetailInfo['usageInstructions'] ?? '미표기'}',
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
                '${pillDetailInfo['storageInstructions'] ?? '미표기'}',
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
                '${pillDetailInfo['standardSpecification'] ?? '미표기'}',
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
                '${pillDetailInfo['productForm'] ?? '미표기'}',
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
              Text('복용 주기 : '),
              Text(
                '${pillDetailInfo['takeCycle']} 일',
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
                '${pillDetailInfo['takeCount']} 회',
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
                '${pillDetailInfo['takeOnceAmount']} 정',
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
class PillNutrientInfo extends StatefulWidget {
  var pillId;

  PillNutrientInfo({super.key, this.pillId});

  @override
  State<PillNutrientInfo> createState() => _PillNutrientInfoState();
}

class _PillNutrientInfoState extends State<PillNutrientInfo> {
  @override
  Widget build(BuildContext context) {
    var pillDetailInfo = context.read<SearchStore>().PillDetailData;
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
