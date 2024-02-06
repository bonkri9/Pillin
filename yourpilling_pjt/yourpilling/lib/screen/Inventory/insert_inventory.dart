import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/screen/Inventory/pill_model.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Inventory/inventory_screen.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:http/http.dart' as http;
import 'package:yourpilling/store/inventory_store.dart';

import 'dart:convert';

import '../../store/search_store.dart';
import '../../store/user_store.dart';

// bool takeYn = false;

class InsertInventory extends StatefulWidget {
  var pillId;

  InsertInventory({super.key, this.pillId});

  @override
  State<InsertInventory> createState() => _InsertInventoryState();
}

class _InsertInventoryState extends State<InsertInventory> {
  TextEditingController remainsController = TextEditingController();
  TextEditingController totalCountController = TextEditingController();

  var pillId;
  var takeYn;
  var remains;
  var totalCount;
  var takeCount;
  var takeOnceAmount;

  @override
  Widget build(BuildContext context) {
    var pillId = widget.pillId;
    void loadData(BuildContext context) {
      context.read<SearchStore>().getSearchDetailData(context, pillId);
    }

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

    loadData(context);
    var pillDetailData = context.read<SearchStore>().PillDetailData;
    print(pillDetailData);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BACKGROUND_COLOR,
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 24,
          disabledColor: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        // color: BACKGROUND_COLOR,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _InsertInvenUpper(
              getTakeYn: getTakeYn,
            ),
            SizedBox(
              height: 30,
            ),
            _InsertInvenContent(
              getCurPillCount: getCurPillCount,
              getTotalPillCount: getTotalPillCount,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: BACKGROUND_COLOR,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
          child: Text(
            '등록',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            context
                .read<InventoryStore>()
                .registInven(context, pillId, takeYn, remains, totalCount);
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    width: 450,
                    height: 200,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.redAccent)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Inventory()));
                            },
                            child: const Text(
                              '등록완료!',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}

class _InsertInvenUpper extends StatefulWidget {
  _InsertInvenUpper({super.key, this.getTakeYn});

  var getTakeYn;

  @override
  State<_InsertInvenUpper> createState() => _InsertInvenUpperState();
}

class _InsertInvenUpperState extends State<_InsertInvenUpper> {
  var takeYn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '영양제 재고 등록',
          style: TextStyle(fontSize: 30),
        ),
        Row(
          children: [
            // LiteRollingSwitch(
            //     width: 100,
            //     // onTap: (bool? value) {
            //     //   setState(() {
            //     //     takeYn = !(value ?? false);
            //     //     widget.getTakeYn(takeYn);
            //     //   });
            //     // },
            //     onTap: () {},
            //     onDoubleTap: () {},
            //     onSwipe: () {},
            //     value: takeYn ?? false,
            //     textOn: '복용중',
            //     textOff: '미복용',
            //     colorOn: Colors.greenAccent,
            //     colorOff: Colors.redAccent,
            //     iconOn: Icons.done,
            //     iconOff: Icons.do_not_disturb_on_outlined,
            //     textSize: 13,
            //     onChanged: (bool? value) {
            //       setState(() {
            //         print(takeYn);
            //         print('아래가 value');
            //         print(value);
            //         takeYn = !(value ?? false);
            //         widget.getTakeYn(takeYn);
            //       });
            //     }),
          ],
        )
      ],
    );
  }
}

class _InsertInvenContent extends StatefulWidget {
  _InsertInvenContent(
      {super.key, this.getCurPillCount, this.getTotalPillCount, this.pillId});

  var getCurPillCount;
  var getTotalPillCount;
  var pillId;

  @override
  State<_InsertInvenContent> createState() => _InsertInvenContentState();
}

class _InsertInvenContentState extends State<_InsertInvenContent> {
  var curPillCount;
  var totalPillCount;

  @override
  Widget build(BuildContext context) {
    var pillId = widget.pillId;
    void loadData(BuildContext context) {
      context.read<SearchStore>().getSearchDetailData(context, pillId);
    }

    loadData(context);
    var pillDetailData = context.read<SearchStore>().PillDetailData;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              fit: BoxFit.cover,
              '${pillDetailData['imageUrl']}',
              width: 250,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        child: RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            text: TextSpan(
                                text: '${pillDetailData['pillName']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ),
                    ],
                  ),
                ),
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
                              // minVal: 0,
                              minVal: curPillCount ?? 0,
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
                            ),
                          ],
                        ),
                      ],
                    )),
                Container(
                    height: 50,
                    child: Row(
                      children: [
                        Text('잔여 알약 수 : '),
                        // Text('${insertInvenInfo[0]['remains']}'),
                        // Text('정'),
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputQty(
                              // maxVal: 500,
                              maxVal: totalPillCount ?? 0,
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
                                setState(() {
                                  curPillCount = value.round();
                                  widget.getCurPillCount(value.round());
                                });
                              },
                              // qtyFormProps: QtyFormProps(enableTyping: false),
                              decoration: QtyDecorationProps(
                                isBordered: false,
                                // borderShape: BorderShapeBtn.circle,
                                minusBtn:
                                    Icon(Icons.remove_circle_outline_rounded),
                                plusBtn: Icon(Icons.add_circle_outline_rounded),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                Container(
                    child: Row(
                  children: [
                    Text('일일 복용 횟수 : '),
                    Text('${pillDetailData['takeCount']}'),
                    Text('회(변경 불가능)'),
                  ],
                )),
                Container(
                    child: Row(
                  children: [
                    Text('1회 복용량 : '),
                    Text('${pillDetailData['takeOnceAmount']}'),
                    Text('정(변경 불가능)'),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
