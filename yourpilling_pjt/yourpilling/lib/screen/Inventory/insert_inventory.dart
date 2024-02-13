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
      // body 시작
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
      // 하단 바
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
          ),
          child: Text(
            '등록',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
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
                    color: Colors.white,
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
  _InsertInvenContent({
    super.key,
    this.getCurPillCount,
    this.getTotalPillCount,
    this.getTakeYn,
    this.detailData,
  });

  final getCurPillCount;
  final getTotalPillCount;

  // var pillId;
  final getTakeYn;
  final detailData;

  @override
  State<_InsertInvenContent> createState() => _InsertInvenContentState();
}

class _InsertInvenContentState extends State<_InsertInvenContent> {
  var curPillCount;
  var totalPillCount;
  var takeYn;
  TextEditingController remainsController = TextEditingController();
  TextEditingController totalCountController = TextEditingController();

  @override
  void dispose() {
    totalCountController.dispose();
    remainsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var pillId = widget.pillId;
    var pillDetailData = widget.detailData;
    var inputWidth = MediaQuery.of(context).size.width * 0.9;

    return Container(
      color: BACKGROUND_COLOR.withOpacity(0.8),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 380,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: BASIC_GREY.withOpacity(0.2),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      '${pillDetailData['imageUrl']}',
                      fit: BoxFit.contain,
                      width: 230,
                      height: 150,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '${pillDetailData['pillName']}',
                        style: TextStyle(
                          fontFamily: "Pretendard",
                          color: BASIC_BLACK,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(9, 5, 9, 5),
                          decoration: BoxDecoration(
                            color: BASIC_GREY.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              width: 0.1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '하루에 ',
                                style: TextStyle(
                                  fontFamily: "Pretendard",
                                  fontSize: 14,
                                  color: BASIC_BLACK.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${pillDetailData['takeCount']}번',
                                style: TextStyle(
                                  fontFamily: "Pretendard",
                                  fontSize: 14,
                                  color: BASIC_BLACK.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 13),
                        Container(
                          padding: EdgeInsets.fromLTRB(9, 5, 9, 5),
                          decoration: BoxDecoration(
                            color: Colors.yellow.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              width: 0.1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '한번에 ',
                                style: TextStyle(
                                  fontFamily: "Pretendard",
                                  fontSize: 14,
                                  color: BASIC_BLACK.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${pillDetailData['takeOnceAmount']}정',
                                style: TextStyle(
                                  fontFamily: "Pretendard",
                                  fontSize: 14,
                                  color: BASIC_BLACK.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // 아래 컨테이너
          Container(
            constraints: BoxConstraints(
              minHeight: 228,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              boxShadow: [
                BoxShadow(
                  color: BASIC_GREY.withOpacity(0.2),
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    children: [
                      Text(
                        '총 몇 정 보유하고 계신가요? ',
                        style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 17,
                            color: BASIC_BLACK,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Focus(
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: totalCountController,
                            onChanged: (value) {
                              setState(() {
                                totalPillCount = int.tryParse(value) ?? 0;
                                widget.getTotalPillCount(totalPillCount);
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: BASIC_GREY.withOpacity(0.15),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          '정',
                          style: TextStyle(
                              fontFamily: "Pretendard",
                              fontSize: 17,
                              color: BASIC_BLACK,
                              fontWeight: FontWeight.w400),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 30),
                  child: Row(
                    children: [
                      Text(
                        '지금은 몇 정 남았나요? ',
                        style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 17,
                            color: BASIC_BLACK,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      Expanded(
                        child: Focus(
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: remainsController,
                            onChanged: (value) {
                              setState(() {
                                curPillCount = int.tryParse(value) ?? 0;
                                widget.getCurPillCount(curPillCount);
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: BASIC_GREY.withOpacity(0.15),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          '정',
                          style: TextStyle(
                              fontFamily: "Pretendard",
                              fontSize: 17,
                              color: BASIC_BLACK,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
