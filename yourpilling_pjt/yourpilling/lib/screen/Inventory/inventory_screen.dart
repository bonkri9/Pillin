import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Inventory/insert_inventory.dart';
import 'package:yourpilling/screen/Search/search_screen.dart';
import 'package:yourpilling/store/inventory_store.dart';
import 'package:yourpilling/store/user_store.dart';
import 'TakenList.dart';
import 'UnTakenList.dart';


class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var userName = context.watch<UserStore>().userName;
    context.read<InventoryStore>().getTakeYnListData(context);

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR.withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "${userName}님의 영양제 재고",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              constraints: BoxConstraints(
                minHeight: 400,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(36),
                    bottomLeft: Radius.circular(36),
                  ),
                  border: Border.all(
                    width: 0.1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x00b5b5b5).withOpacity(0.1),
                        offset: Offset(0.1, 0.1),
                        blurRadius: 3 // 그림자 위치 조정
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "지금 복용 중이에요",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Pretendard",
                            fontSize: 20,
                            color: BASIC_BLACK,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => SearchScreen(showAppBar: true,),
                                  transitionsBuilder: (c, a1, a2, child) =>
                                      SlideTransition(
                                        position: Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0),
                                        )
                                            .chain(CurveTween(curve: Curves.easeInOut))
                                            .animate(a1),
                                        child: child,
                                      ),
                                  transitionDuration: Duration(milliseconds: 750),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: Color(0xFFFF6F61).withOpacity(0.9), // 원의 배경색
                              child: Icon(
                                Icons.add,
                                color: Colors.white, // 화살표 아이콘의 색상
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // 복용 중인 영양제 목록
                  TakenList(),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: screenWidth,
              constraints: BoxConstraints(
                minHeight: 400,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                  border: Border.all(
                    width: 0.1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x00b5b5b5).withOpacity(0.1),
                        offset: Offset(0.1, 0.1),
                        blurRadius: 3 // 그림자 위치 조정
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
                    child: Text(
                      "보관할래요",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Pretendard",
                        fontSize: 20,
                        color: BASIC_BLACK,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // 미복용 중인 영양제 목록
                  UnTakenList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}