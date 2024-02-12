import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:provider/provider.dart';

import '../../store/inventory_store.dart';

void showUpdateUntakenDialog(BuildContext context, var ownPillId, var index){
  var takeFalseListData = context.read<InventoryStore>().takeFalseListData;
  var remains = takeFalseListData?[index]?['remains'] ?? 0;
  var totalCount = takeFalseListData?[index]?['totalCount'] ?? 0;
  var curPillCount = remains;
  var totalPillCount = totalCount;

  String? codeDialog;
  String? valueText;

  showDialog(
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
                            // setState(() {
                            totalPillCount = value.round();
                            // widget.getTotalPillCount(value.round());
                            // });
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
                            // setState(() {
                            curPillCount = value.round();
                            // widget.getCurPillCount(value.round());
                            // });
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
                // setState(() {
                codeDialog = valueText;
                Navigator.pop(context);
                // });
              },
            ),
            MaterialButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              child: const Text('취소'),
              onPressed: () {
                // setState(() {
                Navigator.pop(context);
                // });
              },
            ),
          ],
        );
      });








}