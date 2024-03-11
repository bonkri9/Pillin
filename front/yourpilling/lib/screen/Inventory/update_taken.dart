import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../const/colors.dart';
import '../../store/inventory_store.dart';

void showUpdateTakenDialog(BuildContext context, var ownPillId, var index) {
  var takeTrueListData = context.read<InventoryStore>().takeTrueListData;
  var remains = takeTrueListData?[index]?['remains'] ?? 0;
  var totalCount = takeTrueListData?[index]?['totalCount'] ?? 0;
  var curPillCount = remains;
  var totalPillCount = totalCount;

  String? codeDialog;
  String? valueText;

  showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  '재고를 수정할게요',
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    color: BASIC_BLACK.withOpacity(0.8), // 영양이 부분의 색상을 빨간색으로 지정
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              content: Container(
                width: 350,
                height: 400,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Lottie.asset('assets/lottie/cat-box.json',
                          width: 150, height: 100),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 40, bottom: 10),
                      child: Text(
                        '처음 샀을 땐 몇 정 있었나요?',
                        style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 17,
                            color: BASIC_BLACK,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Focus(
                          child: Container(
                            width: 150,
                            child: TextField(
                              style: TextStyle(
                                color: BASIC_BLACK,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                  text: totalCount.toString()),
                              onChanged: (value) {
                                totalPillCount = int.tryParse(value) ?? 0;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
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
                          padding: const EdgeInsets.only(left: 13, right: 25),
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
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        '지금은 몇 정 남았나요? ',
                        style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 17,
                            color: BASIC_BLACK,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Focus(
                          child: Container(
                            width: 150,
                            child: TextField(
                              style: TextStyle(
                                color: BASIC_BLACK,
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                  text: remains.toString()),
                              onChanged: (value) {
                                curPillCount = int.tryParse(value) ?? 0;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
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
                          padding: const EdgeInsets.only(left: 13, right: 25),
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
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    side: BorderSide(
                      color: Colors.indigoAccent.withOpacity(0.7),
                    ),
                  ),
                  child: Text(
                    '취소',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      color: Colors.indigoAccent.withOpacity(0.7),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.indigoAccent.withOpacity(0.7),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    '완료',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    print(curPillCount);
                    print(totalPillCount);
                    context.read<InventoryStore>().reviseInven(
                        context, ownPillId, curPillCount, totalPillCount);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      });
}
