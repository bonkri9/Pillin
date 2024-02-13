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
  var takeYn = false;
  var remains;
  var totalCount;
  var takeCount;
  var takeOnceAmount;

  @override
  Widget build(BuildContext context) {
    var pillId = widget.pillId;
    context.read<SearchStore>().getSearchDetailData(context, pillId);

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

    var pillDetailData = context.read<SearchStore>().pillDetailData;
    print('pillDetailData $pillDetailData');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          disabledColor: Colors.black,
        ),
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          '내 영양제 등록',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontFamily: "Pretendard",
            fontSize: 20,
            color: BASIC_BLACK.withOpacity(0.9),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _InsertInvenContent(
                getTakeYn: getTakeYn,
                getCurPillCount: getCurPillCount,
                getTotalPillCount: getTotalPillCount,
                detailData: pillDetailData),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
          child: Text(
            '등록',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "Pretendard",
              fontSize: 17,
            ),
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
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              '내 영양제로 등록했어요 :)',
                              style: TextStyle(
                                color: BASIC_BLACK,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Pretendard",
                                fontSize: 17,
                              ),
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

class _InsertInvenContent extends StatefulWidget {
  _InsertInvenContent(
      {super.key,
      this.getCurPillCount,
      this.getTotalPillCount,
      this.pillId,
      this.getTakeYn,
      this.detailData});

  var getCurPillCount;
  var getTotalPillCount;
  var pillId;
  var getTakeYn;
  var detailData;

  @override
  State<_InsertInvenContent> createState() => _InsertInvenContentState();
}

class _InsertInvenContentState extends State<_InsertInvenContent> {
  var curPillCount;
  var totalPillCount;
  var takeYn;

  @override
  Widget build(BuildContext context) {
    var pillId = widget.pillId;
    var pillDetailData = widget.detailData;

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
                                  color: BASIC_BLACK,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("잔여 알약 수는 총 알약 수를 넘을 수 없습니다."),
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
                              initVal: 0,
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
                                if (value == null || value == 0)
                                  return "입력이 필요합니다.";
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
                              initVal: 0,
                              steps: 1,
                              minVal: 0,
                              validator: (value) {
                                if (value == null || value == 0)
                                  return "입력이 필요합니다.";
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
