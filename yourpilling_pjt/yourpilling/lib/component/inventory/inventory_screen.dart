import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:yourpilling/component/angle_container.dart';
import 'package:yourpilling/component/app_bar_search.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/component/pilldetail/search_pill_detail.dart';
import 'package:getwidget/getwidget.dart';
import '../base_container.dart';
import '../app_bar.dart';
import '../login/login_main.dart';
import '../../screen/login_screen.dart';
import '../login/member_register.dart';
import '../login/regist_login_screen.dart';
import '../sign_up/regist_signup_screen.dart';
import '../sign_up/sign_up_screen.dart';
import 'detail_inventory.dart';

bool _takeYnChecked = false;

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  // var takeTrue;
  // var takeFalse;

  String accessToken =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4MDYwMTQsIm1lbWJlcklkIjoyMTA1LCJ1c2VybmFtZSI6InEyIn0.KaJM5_it_HLIz33IOspMOfRGFBHm8MCNAVvqOnWMF-tiyQJ7WlO6T0fjOMslhyAaNXgI4ZNpbsJVyiVR5WQ62g";

  /**
   * {
   *   "ownPillId": int,
   *   "remains": int,
   *   "totalCount": int,
   *   "takeCount": int,
   *   "takeOnceAmount": int,
   *   "takeYn": boolean
   *   }
   */

  getInvenList() async {
    print("재고 목록 요청");

    DateTime now = DateTime.now();
    print('${now.year} 년 ${now.month}월');

    const String invenListUrl =
        "http://10.0.2.2:8080/api/v1/pill/inventory/list";

    var response = await http.get(
      Uri.parse('$invenListUrl?year=${now.year}&month=${now.month}'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      },
    );

    String jsonData = response.body;

    if (response.statusCode == 200) {
      print("재고 목록 데이터 수신 성공");
      print(response.body);
    } else {
      print(response.body);
      print("재고 목록 데이터 수신 실패");
    }
  }

  @override
  void initState() {
    super.initState();
    getInvenList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        barColor: Color(0xFFF5F6F9),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              _InventoryUpper(),
              _InventoryContent(),
              _EtcZone(),
            ]),
          )),
    );
  }
}

//더미 데이터
var takeTrue = [
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 3,
    'predicateRunOutAt': '2024-01-31',
  },
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 10,
    'predicateRunOutAt': '2024-01-12',
  },
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 50,
    'predicateRunOutAt': '2024-01-01',
  },
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 50,
    'predicateRunOutAt': '2024-01-01',
  },
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 50,
    'predicateRunOutAt': '2024-01-01',
  },
];

var takeFalse = [
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 3,
    'predicateRunOutAt': '2024-01-31',
  },
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 10,
    'predicateRunOutAt': '2024-01-12',
  },
  {
    'pillId': '123',
    'imageUrl': '이미지 URL입니다',
    'totalCount': 60,
    'remains': 50,
    'predicateRunOutAt': '2024-01-01',
  },
];

var unTakenPillInven = [
  // {
  //   'pillName': '비타민 C', // 영양제 이름
  //   'currPill': 2, // 현재 갯수
  //   'totalPill': 60, // 전체 갯수
  // },
  {
    'pillName': '아연ee',
    'currPill': 117, // 현재 갯수
    'totalPill': 120, // 전체 갯수
  },
];

class _InventoryUpper extends StatefulWidget {
  const _InventoryUpper({super.key});

  @override
  State<_InventoryUpper> createState() => _InventoryUpperState();
}

class _InventoryUpperState extends State<_InventoryUpper> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // "${userName} 님의 영양제 재고",
            "영양제 재고",
            style: TextStyle(
              color: BASIC_BLACK,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              ' 총 영양제 수 ${takeTrue.length + takeFalse.length} 개 ',
              style: TextStyle(
                color: BASIC_BLACK,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InventoryContent extends StatefulWidget {
  const _InventoryContent({super.key});

  @override
  State<_InventoryContent> createState() => _InventoryContentState();
}

class _InventoryContentState extends State<_InventoryContent> {
  var pillId;
  var takeYn;
  var remains;
  var totalCount;
  var takeCount;
  var takeOnceAmount;

  @override
  Widget build(BuildContext context) {
    String accessToken =
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4MDYwMTQsIm1lbWJlcklkIjoyMTA1LCJ1c2VybmFtZSI6InEyIn0.KaJM5_it_HLIz33IOspMOfRGFBHm8MCNAVvqOnWMF-tiyQJ7WlO6T0fjOMslhyAaNXgI4ZNpbsJVyiVR5WQ62g";

    getTotalNumber(number) {
      setState(() {
        totalCount = number.round();
      });
    }

    getRestNumber(number) {
      setState(() {
        remains = number.round();
      });
    }

    reviseInven() async {
      print(remains);
      print(totalCount);

      const String reviseUrl = "http://10.0.2.2:8080/api/v1/pill/inventory";
      print("재고 수정 요청");
      var response = await http.put(Uri.parse(reviseUrl),
          headers: {
            'Content-Type': 'application/json',
            'accessToken': accessToken,
          },
          body: json.encode({
            'ownPillId': 253,
            'takeYn': true,
            'remains': remains,
            'totalCount': totalCount,
            'takeCount': 1,
            'takeOnceAmount': 1,
            'takeWeekdays': ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"],
          }));
      // 바디 다시 보기

      if (response.statusCode == 200) {
        print("재고 수정 성공!");
        print(response.body);
      } else {
        print("재고 수정 요청 실패");
        print(response.body);
      }
    }

    return BaseContainer(
      width: 400,
      height: 600,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              indicatorColor: Color(0xFFFF6666),
              labelColor: Color(0xFFFF6666),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              labelStyle: TextStyle(fontSize: 20.0),
              tabs: [
                Tab(text: '복용중'),
                Tab(text: '미복용'),
              ],
            ),
            Expanded(
                child: TabBarView(
              // TabBarView(
              children: [
                _TakenTab(
                    getTotalNumber: getTotalNumber,
                    getRestNumber: getRestNumber,
                    reviseInven: reviseInven),
                _UntakenTab(),
              ],
            ))
            // TabBarView(
            //   children: [
            //     // 복용중
            //     buildTabContent(true),
            //
            //     // 미복용
            //     buildTabContent(false),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

//takeTrue
class _TakenTab extends StatefulWidget {
  _TakenTab(
      {super.key, this.getTotalNumber, this.getRestNumber, this.reviseInven});

  var getTotalNumber;
  var getRestNumber;
  var reviseInven;

  @override
  State<_TakenTab> createState() => _TakenTabState();
}

class _TakenTabState extends State<_TakenTab> {
  final String invenTakeYnUrl =
      "http://10.0.2.2:8080/api/v1/pill/inventory/take-yn";
  String accessToken =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4MDYwMTQsIm1lbWJlcklkIjoyMTA1LCJ1c2VybmFtZSI6InEyIn0.KaJM5_it_HLIz33IOspMOfRGFBHm8MCNAVvqOnWMF-tiyQJ7WlO6T0fjOMslhyAaNXgI4ZNpbsJVyiVR5WQ62g";

  putInvenTakeYn() async {
    print("재고 섭취/미섭취 요청");

    var response = await http.put(
      Uri.parse('$invenTakeYnUrl'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      },
      body: json.encode({
        "ownPillId": 256,
      }),
    );

    if (response.statusCode == 200) {
      print("재고 섭취/미섭취 요청 수신 성공");
      print(response.body);
      var accessToken =
          response.headers['accesstoken']; // 이거 Provider 로 전역에 저장해보자
      print(accessToken);
    } else {
      print(response.body);
      print("재고 섭취/미섭취 요청 수신 실패");
    }
  }

  //영양제 상태에 따른 조건문
  Container pillStatus(int i, var takeTrue) {
    // int currPill = pillInvenInfo[i]['currPill'];
    // int totalPill = pillInvenInfo[i]['totalPill'];

    int remains = takeTrue[i]['remains'];
    int totalCount = takeTrue[i]['totalCount'];

    if (remains / totalCount >= 0.5) {
      return Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            color: Colors.green,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          "충분",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else if (remains / totalCount >= 0.1) {
      return Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          border: Border.all(
            color: Colors.orangeAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          "적당",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      return Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(
            color: Colors.redAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          "부족",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _updateInvenDialog(BuildContext context) async {
    var restNumber = 0;
    var totalNumber = 0;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('재고 수정'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text('총 알약 수 : '),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputQty(
                            maxVal: 500,
                            initVal: 1,
                            steps: 1,
                            minVal: 0,
                            validator: (value) {
                              if (value == null) return "입력이 필요합니다.";
                              if (value < 0) {
                                return "";
                              } else if (value > 500) {
                                return "입력값 초과";
                              }
                              return null;
                            },
                            onQtyChanged: (value) {
                              totalNumber = value.round();
                              widget.getTotalNumber(totalNumber);
                            },
                            // qtyFormProps: QtyFormProps(enableTyping: false),
                            decoration: QtyDecorationProps(
                              isBordered: false,
                              // borderShape: BorderShapeBtn.circle,
                              minusBtn:
                                  Icon(Icons.remove_circle_outline_rounded),
                              plusBtn: Icon(Icons.add_circle_outline_rounded),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text('잔여 알약 수 : '),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputQty(
                            maxVal: 500,
                            initVal: 1,
                            steps: 1,
                            minVal: 0,
                            validator: (value) {
                              if (value == null) return "입력이 필요합니다.";
                              if (value < 0) {
                                return "";
                              } else if (value > 500) {
                                return "입력값 초과";
                              }
                              return null;
                            },
                            onQtyChanged: (value) {
                              restNumber = value.round();
                              widget.getRestNumber(restNumber);
                            },

                            // qtyFormProps: QtyFormProps(enableTyping: false),
                            decoration: QtyDecorationProps(
                              isBordered: false,
                              // borderShape: BorderShapeBtn.circle,
                              minusBtn:
                                  Icon(Icons.remove_circle_outline_rounded),
                              plusBtn: Icon(Icons.add_circle_outline_rounded),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.greenAccent,
                textColor: Colors.white,
                child: const Text('완료'),
                onPressed: () {
                  widget.reviseInven();
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.redAccent,
                textColor: Colors.white,
                child: const Text('취소'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String? codeDialog;
  String? valueText;

  @override
  Widget build(BuildContext context) {
    //영양제 잔여량 비율 정렬
    takeTrue.sort((a, b) {
      double resultA = ((a['remains'] as int).toDouble() /
          (a['totalCount'] as int).toDouble());
      double resultB = ((b['remains'] as int).toDouble() /
          (b['totalCount'] as int).toDouble());
      return resultA.compareTo(resultB);
    });

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: takeTrue.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            width: 500,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${takeTrue[i]['pillId']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: BASIC_BLACK,
                        ),
                      ),
                      IconButton(
                        iconSize: 16,
                        onPressed: () {
                          _updateInvenDialog(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              // Text('복용중'),
                              TextButton(
                                  onPressed: () {
                                    putInvenTakeYn();
                                  },
                                  child: Text(
                                    "복용중단",
                                    style: TextStyle(color: Colors.redAccent),
                                  )),
                              Row(
                                children: [
                                  Text(
                                    "${takeTrue[i]['remains']}/${takeTrue[i]['totalCount']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: BASIC_BLACK,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  pillStatus(i, takeTrue),
                                ],
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  textStyle: const TextStyle(fontSize: 10),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InvenDetailScreen()));
                                },
                                child: const Text(
                                  '상세 보기',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _UntakenTab extends StatefulWidget {
  const _UntakenTab({super.key});

  @override
  State<_UntakenTab> createState() => _UntakenTabState();
}

class _UntakenTabState extends State<_UntakenTab> {
  final String invenTakeYnUrl =
      "http://10.0.2.2:8080/api/v1/pill/inventory/take-yn";
  String accessToken =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0b2tlbiIsInJvbGUiOiJNRU1CRVIiLCJleHAiOjE3MDY4MDYwMTQsIm1lbWJlcklkIjoyMTA1LCJ1c2VybmFtZSI6InEyIn0.KaJM5_it_HLIz33IOspMOfRGFBHm8MCNAVvqOnWMF-tiyQJ7WlO6T0fjOMslhyAaNXgI4ZNpbsJVyiVR5WQ62g";

  putInvenTakeYn() async {
    print("재고 섭취/미섭취 요청");

    var response = await http.put(
      Uri.parse('$invenTakeYnUrl'),
      headers: {
        'Content-Type': 'application/json',
        'accessToken': accessToken,
      },
      body: json.encode({
        "ownPillId": 256,
      }),
    );

    if (response.statusCode == 200) {
      print("재고 섭취/미섭취 요청 수신 성공");
      print(response.body);
      var accessToken =
          response.headers['accesstoken']; // 이거 Provider 로 전역에 저장해보자
      print(accessToken);
    } else {
      print(response.body);
      print("재고 섭취/미섭취 요청 수신 실패");
    }
  }

  //영양제 상태에 따른 조건문
  Container pillStatus(int i, var takeFalse) {
    // int currPill = pillInvenInfo[i]['currPill'];
    // int totalPill = pillInvenInfo[i]['totalPill'];

    int remains = takeFalse[i]['remains'];
    int totalCount = takeFalse[i]['totalCount'];

    if (remains / totalCount >= 0.5) {
      return Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(
            color: Colors.green,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          "충분",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else if (remains / totalCount >= 0.1) {
      return Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          border: Border.all(
            color: Colors.orangeAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          "적당",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      return Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(
            color: Colors.redAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Text(
          "부족",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _updateInvenDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('재고 수정'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text('총 알약 수 : '),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputQty(
                            maxVal: 500,
                            initVal: 1,
                            steps: 1,
                            minVal: 0,
                            validator: (value) {
                              if (value == null) return "입력이 필요합니다.";
                              if (value < 0) {
                                return "";
                              } else if (value > 500) {
                                return "입력값 초과";
                              }
                              return null;
                            },
                            // qtyFormProps: QtyFormProps(enableTyping: false),
                            decoration: QtyDecorationProps(
                              isBordered: false,
                              // borderShape: BorderShapeBtn.circle,
                              minusBtn:
                                  Icon(Icons.remove_circle_outline_rounded),
                              plusBtn: Icon(Icons.add_circle_outline_rounded),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Text('잔여 알약 수 : '),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputQty(
                            maxVal: 500,
                            initVal: 1,
                            steps: 1,
                            minVal: 0,
                            validator: (value) {
                              if (value == null) return "입력이 필요합니다.";
                              if (value < 0) {
                                return "";
                              } else if (value > 500) {
                                return "입력값 초과";
                              }
                              return null;
                            },
                            // qtyFormProps: QtyFormProps(enableTyping: false),
                            decoration: QtyDecorationProps(
                              isBordered: false,
                              // borderShape: BorderShapeBtn.circle,
                              minusBtn:
                                  Icon(Icons.remove_circle_outline_rounded),
                              plusBtn: Icon(Icons.add_circle_outline_rounded),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.greenAccent,
                textColor: Colors.white,
                child: const Text('완료'),
                onPressed: () {
                  setState(() {
                    codeDialog = valueText;
                    Navigator.pop(context);
                  });
                },
              ),
              MaterialButton(
                color: Colors.redAccent,
                textColor: Colors.white,
                child: const Text('취소'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  String? codeDialog;
  String? valueText;

  @override
  Widget build(BuildContext context) {
    //영양제 잔여량 비율 정렬
    takeTrue.sort((a, b) {
      double resultA = ((a['remains'] as int).toDouble() /
          (a['totalCount'] as int).toDouble());
      double resultB = ((b['remains'] as int).toDouble() /
          (b['totalCount'] as int).toDouble());
      return resultA.compareTo(resultB);
    });

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: takeTrue.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            width: 500,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${takeTrue[i]['pillId']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: BASIC_BLACK,
                        ),
                      ),
                      IconButton(
                        iconSize: 16,
                        onPressed: () {
                          _updateInvenDialog(context);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          // Text('복용여부'),
                          TextButton(
                              onPressed: () {
                                putInvenTakeYn();
                              },
                              child: Text(
                                "복용시작",
                                style: TextStyle(color: Colors.redAccent),
                              )),
                        ],
                      ),
                      // GFToggle(
                      //   onChanged: (bool? value) {
                      //     setState(() {
                      //       _takeYnChecked = value ?? false;
                      //     });
                      //   },
                      //   value: _takeYnChecked,
                      //   enabledTrackColor: Colors.redAccent,
                      // ),
                      Row(
                        children: [
                          Text(
                            "${takeTrue[i]['remains']}/${takeTrue[i]['totalCount']}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: BASIC_BLACK,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          pillStatus(i, takeTrue),
                        ],
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textStyle: const TextStyle(fontSize: 10),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InvenDetailScreen()));
                        },
                        child: const Text(
                          '상세 보기',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EtcZone extends StatelessWidget {
  const _EtcZone({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseContainer(
            width: 200,
            height: 35,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("로그인",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ),
          BaseContainer(
            width: 200,
            height: 35,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("회원가입",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ),
          BaseContainer(
            width: 200,
            height: 35,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreenView()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("로그인2",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
