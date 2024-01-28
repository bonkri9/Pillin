import 'package:flutter/material.dart';
import 'package:yourpilling/component/angle_container.dart';
import 'package:yourpilling/component/app_bar_search.dart';
import 'package:yourpilling/const/colors.dart';

import 'package:yourpilling/component/pilldetail/search_pill_detail.dart';
import '../component/base_container.dart';
import '../component/app_bar.dart';
import '../component/login/login_main.dart';
import '../component/login/member_register.dart';

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
var userName = "성현";
int takenPill = 0;
var takenPillInven = [
  {
    'pillName': '비타민 C', // 영양제 이름
    'currPill': 2, // 현재 갯수
    'totalPill': 60, // 전체 갯수
    'takeYn': true,
  },
  {
    'pillName': '아연',
    'currPill': 5, // 현재 갯수
    'totalPill': 120, // 전체 갯수
    'takeYn': true,
  },
  {
    'pillName': '마그네슘',
    'currPill': 10, // 현재 갯수
    'totalPill': 50, // 전체 갯수
    'takeYn': false,
  },
  {
    'pillName': '루테인',
    'currPill': 12, // 현재 갯수
    'totalPill': 60, // 전체 갯수
    'takeYn': true,
  },
  {
    'pillName': '칼슘',
    'currPill': 50, // 현재 갯수
    'totalPill': 60, // 전체 갯수
    'takeYn': true,
  },
  {
    'pillName': '오메가-3',
    'currPill': 50, // 현재 갯수
    'totalPill': 60, // 전체 갯수
    'takeYn': true,
  },
  {
    'pillName': '아르기닌',
    'currPill': 50, // 현재 갯수
    'totalPill': 60, // 전체 갯수
    'takeYn': true,
  },
  {
    'pillName': '비타민 C', // 영양제 이름
    'currPill': 2, // 현재 갯수
    'totalPill': 60, // 전체 갯수
    'takeYn': false,
  },
  {
    'pillName': '아연',
    'currPill': 117, // 현재 갯수
    'totalPill': 120, // 전체 갯수
    'takeYn': false,
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
              ' 총 영양제 수 ${takenPillInven.length + unTakenPillInven.length} 개 ',
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

  // Widget buildTabContent(bool takeYn) {
  //   // takeYn에 따라 다른 내용을 반환
  //   List<Widget> pillsInTab = takenPillInven
  //       .where((pill) => pill['takeYn'] == takeYn)
  //       .map((pill) => ListTile(
  //     title: Text('Pill Name: ${pill['pillName']}'),
  //     subtitle: Text('Num1: ${pill['num1']}'),
  //   ))
  //       .toList();
  //
  //   return ListView(
  //     children: pillsInTab,
  //   );
  // }
}

class _TakenTab extends StatefulWidget {
  const _TakenTab({super.key});

  @override
  State<_TakenTab> createState() => _TakenTabState();
}

class _TakenTabState extends State<_TakenTab> {
  //영양제 상태에 따른 조건문
  Container pillStatus(int i, var pillInvenInfo) {
    int currPill = pillInvenInfo[i]['currPill'];
    int totalPill = pillInvenInfo[i]['totalPill'];

    if (currPill / totalPill >= 0.5) {
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
    } else if (currPill / totalPill >= 0.1) {
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
    //영양제 잔여량 비율 정렬
    takenPillInven.sort((a, b) {
      double resultA = ((a['currPill'] as int).toDouble() /
          (a['totalPill'] as int).toDouble());
      double resultB = ((b['currPill'] as int).toDouble() /
          (b['totalPill'] as int).toDouble());
      return resultA.compareTo(resultB);
    });

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: takenPillInven.length,
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
                    "${takenPillInven[i]['pillName']}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: BASIC_BLACK,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${takenPillInven[i]['currPill']}/${takenPillInven[i]['totalPill']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: BASIC_BLACK,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      pillStatus(i, takenPillInven),
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
  Container pillStatus(int i, var pillInvenInfo) {
    int currPill = pillInvenInfo[i]['currPill'];
    int totalPill = pillInvenInfo[i]['totalPill'];

    if (currPill / totalPill >= 0.5) {
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
    } else if (currPill / totalPill >= 0.1) {
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
      itemCount: unTakenPillInven.length,
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
                    "${unTakenPillInven[i]['pillName']}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: BASIC_BLACK,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${unTakenPillInven[i]['currPill']}/${unTakenPillInven[i]['totalPill']}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: BASIC_BLACK,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      pillStatus(i, unTakenPillInven),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseContainer(
            width: 130,
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
            width: 100,
            height: 35,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginMain()));
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
            width: 100,
            height: 35,
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemberRegister()));
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
        ],
      ),
    );
  }
}
