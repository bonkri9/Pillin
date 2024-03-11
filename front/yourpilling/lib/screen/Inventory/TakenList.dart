import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Inventory/update_taken.dart';
import 'package:yourpilling/screen/Search/search_screen.dart';
import '../../store/inventory_store.dart';

class TakenList extends StatefulWidget {
  const TakenList({super.key});

  @override
  State<TakenList> createState() => _TakenListState();
}

class _TakenListState extends State<TakenList> {
  @override
  Widget build(BuildContext context) {
    var tmp = context.watch<InventoryStore>().takeYnListData;
    var takeTrueList = context.watch<InventoryStore>().takeTrueListData;
    var screenWidth = MediaQuery.of(context).size.width * 0.91;
    var imageWidth = MediaQuery.of(context).size.width * 0.3;

    Color sufficientColor = Colors.greenAccent.withOpacity(0.1);
    Color normalColor = Colors.yellow;
    Color dangerColor = Colors.redAccent;
    Color inventoryColor = Colors.white; // 버튼 색상 초기값 할당

    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(), // ListView 스크롤 방지
        shrinkWrap: true,
        itemCount: takeTrueList.length, // 이거 해놔서 따로 예외 처리 안해도 됨
        itemBuilder: (context, i) {
          if (takeTrueList[i]['remains'] / takeTrueList[i]['totalCount'] > 0.5) {
            inventoryColor = sufficientColor;
          } else if (takeTrueList[i]['remains'] / takeTrueList[i]['totalCount'] >= 0.2) {
            inventoryColor = normalColor;
          } else {
            inventoryColor = dangerColor;
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        width: 0.1,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: BASIC_GREY.withOpacity(0.4),
                            offset: Offset(0.1, 0.1),
                            blurRadius: 3 // 그림자 위치 조정
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 25, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end
                          ,children: [
                            GestureDetector(
                              onTap: () {
                                var ownPillId = '${takeTrueList[i]?['ownPillId'] ?? 0}';
                                var index = i;
                                print(index);
                                showUpdateTakenDialog(context, ownPillId, index);
                              },
                              child: Icon(
                                Icons.mode_edit,
                                size: 20,
                                color: BASIC_GREY, // 아이콘 색상
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                          child: Image.network(
                            takeTrueList[i]["imageUrl"],
                            width: imageWidth,
                            height: 100,
                          ),
                        ),
                        Text(
                          takeTrueList[i]['pillName'],
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 15.5,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(13, 8, 13, 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: BASIC_GREY.withOpacity(0.15), // 원의 배경색
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${takeTrueList[i]['remains']}정',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: BASIC_BLACK.withOpacity(0.7),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Pretendard',
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' / ',
                                        style: TextStyle(
                                          color: BASIC_BLACK.withOpacity(0.7),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Pretendard',
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                        '${takeTrueList[i]['totalCount']}정',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: BASIC_BLACK.withOpacity(0.7),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Pretendard',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                // 미복용 탭으로 이동
                                context.read<InventoryStore>().putTakeYnChange(context, takeTrueList[i]['ownPillId']);
                                context.watch<InventoryStore>().takeFalseListData;
                                context.watch<InventoryStore>().takeTrueListData;
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(13, 7, 13, 7),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: Color(0xFFFF6F61).withOpacity(0.9), // 원의 배경색
                                ),
                                child: Text(
                                  '보관하기',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}