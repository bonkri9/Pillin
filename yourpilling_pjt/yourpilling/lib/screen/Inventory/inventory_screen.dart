import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/common/angle_container.dart';
import 'package:yourpilling/component/common/app_bar_search.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Search/search_pill_detail.dart';
import 'package:getwidget/getwidget.dart';
import 'package:yourpilling/store/inventory_store.dart';
import '../../store/user_store.dart';
import '../../component/common/base_container.dart';
import '../../component/common/app_bar.dart';
import 'detail_inventory.dart';

void loadData(BuildContext context) {
  context.watch<InventoryStore>().getTakeYnListData(context);
}

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  //바로바로 렌더링되게 함
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    // void loadData(BuildContext context) {
    //   context.read<InventoryStore>(context, listen: false).getTakeYnListData(context);
    // }
    // loadData(context);
    // void loadData(BuildContext context) {
    //   Provider.of<InventoryStore>(context, listen: false)
    //       .getTakeYnListData(context);
    // }
    //
    // loadData(context);
    // getInvenList(context);
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
              _InventoryContent(
                  // takeYnListData : context.read<InventoryStore>().takeYnListData,
                  ),
            ]),
          )),
    );
  }
}

//재고 상단
class _InventoryUpper extends StatefulWidget {
  const _InventoryUpper({super.key});

  @override
  State<_InventoryUpper> createState() => _InventoryUpperState();
}

//재고 상단
class _InventoryUpperState extends State<_InventoryUpper> {
  @override
  Widget build(BuildContext context) {
    var takeListData = context.read<InventoryStore>().takeYnListData;
    var listAllLength = ((takeListData?['takeTrue']?['data']?.length ?? 0) +
        (takeListData?['takeFalse']?['data']?.length ?? 0));
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
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
              ' 총 영양제 수 $listAllLength 개 ',
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

//재고 내용
class _InventoryContent extends StatefulWidget {
  _InventoryContent({super.key});

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
  var totalNumber;
  var restNumber;

  @override
  Widget build(BuildContext context) {
    // getTotalNumber(number) {
    //   setState(() {
    //     totalCount = number.round();
    //   });
    // }
    //
    // getRestNumber(number) {
    //   setState(() {
    //     remains = number.round();
    //   });
    // }
    loadData(context);
    // 영양제 등록 때 보낼 데이터 변수명
    getCurPillCount(count) {
      setState(() {
        remains = count;
      });
      print(remains);
    }

    getTakeYn(bool) {
      setState(() {
        takeYn = bool;
      });
      print(takeYn);
    }

    getTotalPillCount(count) {
      setState(() {
        totalCount = count;
      });
      print(totalCount);
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
              children: [
                _TakenTab(
                  getCurPillCount: getCurPillCount,
                  getTotalPillCount: getTotalPillCount,
                  // getTotalNumber: getTotalNumber,
                  // getRestNumber: getRestNumber,
                  // takeYnListData: takeYnListData,
                ),
                _UntakenTab(
                  // getTotalNumber: getTotalNumber,
                  // getRestNumber: getRestNumber,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

//takeTrue 복용 영양제
class _TakenTab extends StatefulWidget {
  _TakenTab({
    super.key,
    // this.getTotalNumber,
    // this.getRestNumber,
    this.getCurPillCount,
    this.getTotalPillCount,
  });

  // final getTotalNumber;
  // final getRestNumber;
  var getCurPillCount;
  var getTotalPillCount;
  var pillId;

  @override
  State<_TakenTab> createState() => _TakenTabState();
}

class _TakenTabState extends State<_TakenTab> {
  //바로바로 렌더링되게 함
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData(context);
  }

  // var curPillCount;
  // var totalPillCount;
  var remains;
  var takeYn;
  var totalCount;

  // 영양제 등록 때 보낼 데이터 변수명
  getCurPillCount(count) {
    setState(() {
      remains = count;
    });
    print(remains);
  }

  getTotalPillCount(count) {
    setState(() {
      totalCount = count;
    });
    print(totalCount);
  }

  // getTakeYn(bool) {
  //   setState(() {
  //     takeYn = bool;
  //   });
  //   print(takeYn);
  // }

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

  //재고량 수정창
  Future<void> _updateInvenDialog(
      BuildContext context, var ownPillId, var index) async {
    // void loadData(BuildContext context) {
    //   Provider.of<InventoryStore>(context, listen: false).getTakeYnListData(context);
    // }
    // loadData(context);
    var takeYnListData = context.read<InventoryStore>().takeYnListData;
    var takeTrueListData = context.read<InventoryStore>().takeTrueListData;
    var remains = takeTrueListData?[index]?['remains'] ?? 0;
    var totalCount = takeTrueListData?[index]?['totalCount'] ?? 0;
    // var restNumber = 0;
    // var totalNumber = 0;
    var curPillCount = 0;
    var totalPillCount = 0;
    // var num = remains;
    // curPillCount = remains;
    // totalPillCount = totalCount;
    print(curPillCount);
    print(totalPillCount);
    print('이것임임임임');
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
                      Text('총 갯수 : '),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputQty(
                            maxVal: 500,
                            initVal: totalCount,
                            steps: 1,
                            // minVal: curPillCount.round(),
                            minVal: 0,
                            onQtyChanged: (value) {
                              setState(() {
                                totalPillCount = value.round();
                                widget.getTotalPillCount(value.round());
                              });
                            },
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
                      Text('잔여 갯수 : '),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputQty(
                            // maxVal: totalPillCount.round(),
                            maxVal: 500,
                            initVal: remains,
                            steps: 1,
                            minVal: 0,
                            onQtyChanged: (value) {
                              setState(() {
                                curPillCount = value.round();
                                widget.getCurPillCount(value.round());
                              });
                            },
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
                  print(curPillCount);
                  print(totalPillCount);
                  context
                      .read<InventoryStore>()
                      // .reviseInven(context, ownPillId, restNumber, totalNumber);
                      .reviseInven(
                          context, ownPillId, curPillCount, totalPillCount);
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
    var takeTrueList = context.read<InventoryStore>().takeTrueListData;
    var listLength = context.read<InventoryStore>().length;
    // print(takeTrueListData);
    // loadData(context);
    // var takeTrueListData = context.select((InventoryStore store) => store.takeTrueListData);
    // var listLength = takeTrueListData?.length ?? 0;
    // print(takeTestData);
    // var listLength = takeTrueListData?['takeTrue']?['data']?.length ?? 0;

    print(listLength);
    return ListView.builder(

      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listLength ?? 0,
      itemBuilder: (context, i) {
        dynamic takeTrueData = takeTrueList[i] ?? 0;
        var ownPillId = takeTrueData?['ownPillId'] ?? 0;
        var pillName = takeTrueData?['pillName'] ?? 0;
        var imageUrl = takeTrueData?['imageUrl'] ?? 0;
        var totalCount = takeTrueData?['totalCount'] ?? 0;
        var remains = takeTrueData?['remains'] ?? 0;
        var predicateRunOutAt = takeTrueData?['predicateRunOutAt'] ?? 0;
        var warningMessage = takeTrueData?['warningMessage'] ?? 0;

        print(ownPillId);
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
                      Container(
                        width: 150,
                        child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                                text:
                                    // '${takeTrueListData['takeTrue']['data'][i]['pillName']}',
                                    // '${takeTrueListData?[i]?['pillName'] ?? 0}',
                                    pillName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ),
                      IconButton(
                        iconSize: 16,
                        onPressed: () {
                          // var ownPillId =
                          //     '${takeTrueListData['takeTrue']['data'][i]['ownPillId']}';
                          // var ownPillId = '${takeTrueListData?[i]?['ownPillId'] ?? 0}';
                          var index = i;
                          print(index);
                          print('위는 인덱스');
                          _updateInvenDialog(context, ownPillId, index);
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
                                    setState(() {
                                      context
                                          .read<InventoryStore>()
                                          .putTakeYnChange(context, ownPillId);
                                      context
                                          .read<InventoryStore>()
                                          .takeTrueListData;
                                      context
                                          .read<InventoryStore>()
                                          .getTakeYnListData;
                                    });
                                    // var ownPillId =
                                    //     '${takeTrueListData['takeTrue']['data'][i]['ownPillId']}';
                                    // ownPillId = '${takeTrueListData?[i]?['ownPillId'] ?? 0}';
                                    // Provider.of<UserStore>(context,
                                    //     listen: false);
                                    // context
                                    //     .read<InventoryStore>()
                                    //     .putTakeYnChange(context, ownPillId);
                                    // var newTrueList = context.read<InventoryStore>().takeTrueListData;
                                    // context.read<InventoryStore>().takeTrueListData = newTrueList;
                                    // context.read<InventoryStore>().putPillTake(context); // 복용 요청하기
                                  },
                                  child: Text(
                                    "복용중단",
                                    style: TextStyle(color: Colors.redAccent),
                                  )),
                              Row(
                                children: [
                                  Text(
                                    // "${takeTrueListData['takeTrue']['data'][i]['remains']}/${takeTrueListData['takeTrue']['data'][i]['totalCount']}",
                                    // '${takeTrueListData?[i]?['remains'] ?? 0} / ${takeTrueListData?[i]?['totalCount'] ?? 0}',
                                    '$remains / $totalCount',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: BASIC_BLACK,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  pillStatus(
                                      // i, takeTrueListData['takeTrue']['data']),
                                      i,
                                      takeTrueList ?? 0),
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
                                  // var ownPillId = takeTrueListData['takeTrue']
                                  //         ['data'][i]['ownPillId'] ??
                                  //     0;
                                  // ownPillId = takeTrueListData[i]['ownPillId'] ?? 0;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InvenDetailScreen(
                                                ownPillId: ownPillId,
                                              )));
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

//takeFalse 미복용 영양제
class _UntakenTab extends StatefulWidget {
  _UntakenTab(
      {super.key, this.getTotalNumber, this.getRestNumber,
      });

  final getTotalNumber;
  final getRestNumber;

  @override
  State<_UntakenTab> createState() => _UntakenTabState();
}

//takeFalse 미복용 영양제
class _UntakenTabState extends State<_UntakenTab> {
  //영양제 상태에 따른 조건문
  Container pillStatus(int i, var takeFalse) {
    int remains = takeFalse?[i]?['remains'] ?? 0;
    int totalCount = takeFalse?[i]?['totalCount'] ?? 0;

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

  Future<void> _updateInvenDialog(BuildContext context, var ownPillId) async {
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
                  context
                      .read<InventoryStore>()
                      .reviseInven(context, ownPillId, restNumber, totalNumber);
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
    var takeFalseListData = context.watch<InventoryStore>().takeYnListData;
    var listLength = takeFalseListData?['takeFalse']?['data']?.length ?? 0;
    print(listLength);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: listLength ?? 0,
      itemBuilder: (context, i) {
        var ownPillId = takeFalseListData['takeFalse']['data'][i]['ownPillId'];
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
                      Container(
                        width: 150,
                        child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                                text:
                                    '${takeFalseListData['takeFalse']['data'][i]['pillName']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ),
                      IconButton(
                        iconSize: 16,
                        onPressed: () {
                          var ownPillId =
                              '${takeFalseListData['takeFalse']['data'][i]['ownPillId']}';
                          _updateInvenDialog(context, ownPillId);
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
                                    var ownPillId =
                                        '${takeFalseListData['takeFalse']['data'][i]['ownPillId']}';
                                    // Provider.of<UserStore>(context,
                                    //     listen: false);
                                    context
                                        .read<InventoryStore>()
                                        .putTakeYnChange(context, ownPillId);
                                  },
                                  child: Text(
                                    "복용시작",
                                    style: TextStyle(color: Colors.greenAccent),
                                  )),
                              Row(
                                children: [
                                  Text(
                                    "${takeFalseListData['takeFalse']['data'][i]['remains']}/${takeFalseListData['takeFalse']['data'][i]['totalCount']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: BASIC_BLACK,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  pillStatus(i,
                                      takeFalseListData['takeFalse']['data']),
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
                                  var ownPillId = takeFalseListData['takeFalse']
                                          ['data'][i]['ownPillId'] ??
                                      0;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InvenDetailScreen(
                                                ownPillId: ownPillId,
                                              )));
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

