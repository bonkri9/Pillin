import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yourpilling/component/app_bar.dart';
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
            child: ListView(
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
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ' 환영해요',
                              style: TextStyle(
                                color: Color(0xFFFF6666),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 155),
                              child: Text(
                                ' 1월 23일',
                                style: TextStyle(
                                  color: Colors.black54,
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
                                  color: Colors.black87,
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
                      height: 170,
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
                                  color: Colors.black87,
                                ),),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AlarmScreen()));
                                  },
                                  icon: Icon(Icons.add, size: 15,),
                                ),
                              ],
                            ),
                          ),
                          // Progress Bar
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
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
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Container(
                                width: 300,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text("1"),
                                  ],
                                )),
                          )
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
                                  color: Colors.black87,
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
                ])
        )
    );
  }
}
