import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yourpilling/component/app_bar.dart';
import 'package:yourpilling/const/colors.dart';
import 'search_screen.dart';
import 'record_screen.dart';
import 'alarm_screen.dart';
import 'inventory_screen.dart';
import '../component/BaseContainer.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime _selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(barColor: Color(0xFFFFF5F4),),

        body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
              color: Color(0xFFFFF5F4),
            ),
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 25),
                          child: Row(
                            children: [
                              Text(
                                '성현님',
                                style: TextStyle(
                                  color: LIGHT_BLACK,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' 환영해요',
                                style: TextStyle(
                                  color: Color(0xFFFF6666),
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 155),
                                child: Text(
                                  ' 1월 23일',
                                  style: TextStyle(
                                    color: BASIC_BLACK,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    BaseContainer(
                      width: 350,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("어떤 영양제를 찾으세요?", style: TextStyle(
                              color: Colors.grey,
                            )),
                            Icon(Icons.search, color: Color(0xFFFF6666)),
                          ],
                        ),
                      ),
                    ),
                    BaseContainer(
                        width: 350,
                        height: 130,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Text("주간 복용 현황", style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.5,
                                      color: BASIC_BLACK,
                                      ),),
                                      IconButton(
                                      onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => RecordScreen()));
                                    },
                                    icon: Icon(Icons.arrow_forward_ios, size: 15,),
                                  ),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: WeeklyDatePicker(
                                selectedDay: _selectedDay,
                                changeDay: (value) => setState(() {
                                  _selectedDay = value;
                                }),
                                enableWeeknumberText: false,
                                backgroundColor: Colors.white,
                                digitsColor: Colors.grey.withOpacity(0.7),
                                selectedDigitBackgroundColor: Color(0xFFFF6666),
                                weekdayTextColor: Color(0xFFFF6666),
                                weekdays: ["MON", "TUE", "WED", "THR", "FRI", "SAT", "SUN"],
                                daysInWeek: 7,
                              ),)


                          ],
                        )
                    ),
                    BaseContainer(
                        width: 350,
                        height: 230,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("오늘 먹을 영양제", style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.5,
                                    color: BASIC_BLACK,
                                  )),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AlarmScreen()));
                                    },
                                    icon: Icon(Icons.add, size: 15,),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text("50%", style: TextStyle(fontWeight: FontWeight.w600, color: BASIC_BLACK),),
                              ),
                            ),
                            // Progress Bar
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: AnimatedProgressBar(
                                width: 300,
                                value: 0.5 ,
                                duration: const Duration(seconds: 1),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.orangeAccent,
                                    Colors.redAccent,
                                  ],
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                              child: Container(
                                  width: 300,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset('assets/image/1.png', width: 17, height: 17,),
                                        Text("비타민 C", style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: LIGHT_BLACK,
                                        )),
                                        Text("09:00", style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: LIGHT_BLACK,
                                        )),
                                        Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            border: Border.all(
                                              color: Colors.redAccent,
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          child: TextButton(
                                            onPressed: () {},
                                            style: ButtonStyle(
                                            padding: MaterialStateProperty.all(EdgeInsets.zero), // 패딩 없애줘야 함
                                            ),
                                            child: Text("완료", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            )),
                                            ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            //   child: Container(
                            //       width: 300,
                            //       height: 45,
                            //       decoration: BoxDecoration(
                            //         color: Colors.grey.withOpacity(0.08),
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       child: Padding(
                            //         padding: const EdgeInsets.all(10.0),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Image.asset('assets/image/2.png', width: 17, height: 17,),
                            //             Text("루테인", style: TextStyle(
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 14,
                            //               color: LIGHT_BLACK,
                            //             )),
                            //             Text("12:00", style: TextStyle(
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 14,
                            //               color: LIGHT_BLACK,
                            //             )),
                            //             Container(
                            //               width: 50,
                            //               decoration: BoxDecoration(
                            //                 color: Colors.white,
                            //                 border: Border.all(
                            //                   color: Colors.redAccent,
                            //                   width: 1,
                            //                 ),
                            //                 borderRadius: BorderRadius.all(Radius.circular(20)),
                            //               ),
                            //               child: TextButton(
                            //                   onPressed: () {},
                            //                 style: ButtonStyle(
                            //                   padding: MaterialStateProperty.all(EdgeInsets.zero), // 패딩 없애줘야 함
                            //                 ),
                            //                 child: Text("복용", style: TextStyle(
                            //                 color: Colors.redAccent,
                            //                 fontSize: 13,
                            //                 fontWeight: FontWeight.w600,
                            //                   )),
                            //               ),
                            //             )
                            //           ],
                            //         ),
                            //       )),
                            // )
                          ],
                        )
                    ),
                    BaseContainer(
                        width: 350,
                        height: 200,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("내 영양제 재고", style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13.5,
                                    color: BASIC_BLACK,
                                  ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Inventory()));
                                    },
                                    icon: Icon(Icons.arrow_forward_ios, size: 15,),),
                                ],
                              ),
                            ),
                          ],
                        )
                    )
                  ]),
            )
        )
    );
  }
}
