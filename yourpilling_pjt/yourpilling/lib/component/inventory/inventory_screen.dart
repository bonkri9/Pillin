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
import '../login/login_screen.dart';
import '../login/member_register.dart';
import '../login/regist_login_screen.dart';
import '../sign_up/regist_signup_screen.dart';
import '../sign_up/sign_up_screen.dart';

bool _takeYnChecked = false;

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
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
    'pillId' : '123',
    'imageUrl' : '이미지 URL입니다',
    'totalCount' : 60,
    'remains' : 3,
    'predicateRunOutAt' : '2024-01-31',
  },
  {
    'pillId' : '123',
    'imageUrl' : '이미지 URL입니다',
    'totalCount' : 60,
    'remains' : 10,
    'predicateRunOutAt' : '2024-01-12',
  },
  {
    'pillId' : '123',
    'imageUrl' : '이미지 URL입니다',
    'totalCount' : 60,
    'remains' : 50,
    'predicateRunOutAt' : '2024-01-01',
  },
];

var takeFalse = [
  {
    'pillId' : '123',
    'imageUrl' : '이미지 URL입니다',
    'totalCount' : 60,
    'remains' : 3,
    'predicateRunOutAt' : '2024-01-31',
  },
  {
    'pillId' : '123',
    'imageUrl' : '이미지 URL입니다',
    'totalCount' : 60,
    'remains' : 10,
    'predicateRunOutAt' : '2024-01-12',
  },
  {
    'pillId' : '123',
    'imageUrl' : '이미지 URL입니다',
    'totalCount' : 60,
    'remains' : 50,
    'predicateRunOutAt' : '2024-01-01',
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
  @override
  Widget build(BuildContext context) {
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
                _TakenTab(),
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
  const _TakenTab({super.key});

  @override
  State<_TakenTab> createState() => _TakenTabState();
}

class _TakenTabState extends State<_TakenTab> {
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
                            validator: (value){
                              if(value == null) return "입력이 필요합니다.";
                              if(value < 0){
                                return "";
                              }else if(value>500){
                                return "입력값 초과";
                              }
                              return null;
                            },
                            // qtyFormProps: QtyFormProps(enableTyping: false),
                            decoration: QtyDecorationProps(
                              isBordered: false,
                              // borderShape: BorderShapeBtn.circle,
                              minusBtn: Icon(
                                  Icons.remove_circle_outline_rounded
                              ),
                              plusBtn: Icon(
                                  Icons.add_circle_outline_rounded
                              ),
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
                            validator: (value){
                              if(value == null) return "입력이 필요합니다.";
                              if(value < 0){
                                return "";
                              }else if(value>500){
                                return "입력값 초과";
                              }
                              return null;
                            },
                            // qtyFormProps: QtyFormProps(enableTyping: false),
                            decoration: QtyDecorationProps(
                              isBordered: false,
                              // borderShape: BorderShapeBtn.circle,
                              minusBtn: Icon(
                                  Icons.remove_circle_outline_rounded
                              ),
                              plusBtn: Icon(
                                  Icons.add_circle_outline_rounded
                              ),
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
            height: 100,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text('복용여부'),
                          SizedBox(
                            width: 10,
                          ),
                          GFToggle(
                            onChanged: (bool? value) {
                              setState(() {
                                _takeYnChecked = value ?? false;
                              });
                            },
                            value: _takeYnChecked,
                            enabledTrackColor: Colors.redAccent,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${takeTrue[i]['remains']}/${takeTrue[i]['totalCount']}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
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
                                  builder: (context) => PillDetailScreen()));
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

class _UntakenTab extends StatefulWidget {
  const _UntakenTab({super.key});

  @override
  State<_UntakenTab> createState() => _UntakenTabState();
}

class _UntakenTabState extends State<_UntakenTab> {
  //영양제 상태에 따른 조건문
  Container pillStatus(int i, var takeFalse) {
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: takeFalse.length,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            width: 500,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${takeFalse[i]['pillId']}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: BASIC_BLACK,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${takeFalse[i]['remains']}/${takeFalse[i]['totalCount']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: BASIC_BLACK,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      pillStatus(i, takeFalse),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PillDetailScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("영양제 상세페이지",
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
