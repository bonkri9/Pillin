import 'dart:math';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/screen/Search/search_screen.dart';
import 'package:yourpilling/store/inventory_store.dart';

import '../../component/common/base_container_noheight.dart';
import '../../const/colors.dart';
import '../../store/analysis_report_store.dart';
import '../../store/search_store.dart';
import '../../store/user_store.dart';
import '../Search/search_pill_detail.dart';

class AnalysisReport extends StatefulWidget {
  const AnalysisReport({super.key});

  @override
  State<AnalysisReport> createState() => _AnalysisReportState();
}

class _AnalysisReportState extends State<AnalysisReport> {
  @override
  Widget build(BuildContext context) {
    context.read<InventoryStore>().getTakeYnListData(context);
    context.read<InventoryStore>().takeTrueListData;
    context.read<AnalysisReportStore>().getEssentialNutrientsDataList(context);
    context.read<AnalysisReportStore>().getVitaminBGroupDataList(context);
    context.read<AnalysisReportStore>().getRecommendList(context);

    var userDetailInfo = context.watch<UserStore>().UserDetail;
    var takeTrueListData = context.read<InventoryStore>().takeTrueListData;
    var takeTrueListDataLength = takeTrueListData.length;

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR.withOpacity(0.8),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(
          "${userDetailInfo?['name'] ?? ""}님의 분석 리포트",
          style: TextStyle(
            color: BASIC_BLACK,
            fontSize: 25,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              takeTrueListData == null || takeTrueListDataLength == 0
                  ? Column(
                      //복용중인 영양제가 없다면 표시할 것들
                      children: [
                        Container(
                          width: 350,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: '아직 분석할 복용 영양제가 없어요',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: BASIC_BLACK,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Pretendard',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              // 추가 버튼
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (c, a1, a2) =>
                                          SearchScreen(showAppBar: true,),
                                      transitionsBuilder: (c, a1, a2, child) =>
                                          SlideTransition(
                                        position: Tween(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset(0.0, 0.0),
                                        )
                                            .chain(CurveTween(
                                                curve: Curves.easeInOut))
                                            .animate(a1),
                                        child: child,
                                      ),
                                      transitionDuration:
                                          Duration(milliseconds: 750),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 15.0,
                                  backgroundColor: Colors.yellow, // 원의 배경색
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white, // 화살표 아이콘의 색상
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      //복용 중인 영양제가 있다면 표시할 것들
                      children: [
                        _ReportIntro(), //리포트 개요
                        SizedBox(
                          height: 15,
                        ),
                        _EssentialNutrients(), //필수영양소 레이더
                        SizedBox(
                          height: 15,
                        ),
                        _VitaminBGroupRadar(), //비타민 B군 레이더
                        SizedBox(
                          height: 15,
                        ),
                        // _VitaminBGroup(),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        _RecommendList(), //추천리스트
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

//분석리포트 개요
class _ReportIntro extends StatefulWidget {
  const _ReportIntro({super.key});

  @override
  State<_ReportIntro> createState() => _ReportIntroState();
}

class _ReportIntroState extends State<_ReportIntro> {
  @override
  Widget build(BuildContext context) {
    var takeTrueList = context.watch<InventoryStore>().takeTrueListData;
    var userDetailInfo = context.read<UserStore>().UserDetail;
    var imageWidth = MediaQuery.of(context).size.width * 0.3;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
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
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${userDetailInfo?['name'] ?? ""}의 분석리포트입니다.",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "(현재 복용 중인 영양제 기준)",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "복용 중인 영양제 목록",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: takeTrueList.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(5, 15, 0, 15),
                                child: Image.network(
                                  takeTrueList[i]["imageUrl"],
                                  width: imageWidth,
                                  height: 100,
                                ),
                              ),
                              Container(
                                width: 200,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  text: TextSpan(
                                    text: takeTrueList[i]['pillName'],
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: "Pretendard",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 15.5,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//필수영양소 레이더 그래프
class _EssentialNutrients extends StatefulWidget {
  const _EssentialNutrients({super.key});

  @override
  State<_EssentialNutrients> createState() => _EssentialNutrientsState();
}

class _EssentialNutrientsState extends State<_EssentialNutrients> {
  var darkMode = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var essentialNutrientDataList =
        context.watch<AnalysisReportStore>().essentialNutrientDataList;
    var essentialNutrientDataLisLength =
        context.watch<AnalysisReportStore>().essentialNutrientDataLisLength;
    var numberOfFeatures = essentialNutrientDataLisLength;

    const ticks = [50, 100, 150];

    List<dynamic> dynamicList = essentialNutrientDataList;
    List<String> features = List<String>.from(
        dynamicList.map((nutrient) => nutrient["nutrientsName"].toString()));

// data 리스트 생성
    List<List<double>> data = [
      dynamicList
          .map((nutrient) => (nutrient["data"]["recommendedIntake"] /
              nutrient["data"]["recommendedIntake"] *
              100 as double))
          .toList(),
      dynamicList.map((nutrient) {
        double value = (nutrient["data"]["userIntake"] /
            nutrient["data"]["recommendedIntake"] *
            100) as double;
        return value > 150 ? 150.0 : value;
      }).toList(),
    ];

    print(data);
    print(features);

    return Container(
      width: screenWidth,
      constraints: BoxConstraints(
        minHeight: 210,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
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
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "필수 영양소 섭취 분석",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "(100%가 권장섭취량입니다.)",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "단위 : [%]",
                        style: TextStyle(fontSize: 15),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              height: 300,
              // color: Colors.white, //배경색
              child: RadarChart(
                //차트 축 기준
                ticks: ticks,
                // 각각의 영양소 이름
                features: features,
                // 각 영양소 수치
                data: data,
                // 데이터 표시 범위 색상 변경 : 리스트 타입으로 색상을 나열
                graphColors: const [
                  Colors.yellow, // features(현재 섭취량) 빨간색으로 표시
                  Colors.red, // data(권장섭취량) 노란색으로 표시
                ],
                axisColor: Colors.green,
                // 축 색상 변경
                outlineColor: Colors.grey,
                // 차트 테두리 색상 변경
                // 축 표시 글꼴 색상 변경
                ticksTextStyle:
                    const TextStyle(color: Colors.green, fontSize: 16),
                // 피처 표시 글꼴 색상 변경
                featuresTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                // 축 표시 값 반전 : 기본값 false
                reverseAxis: false,
                // 다각형 설정
                sides: essentialNutrientDataLisLength,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//비타민 B군 레이더 그래프
class _VitaminBGroupRadar extends StatefulWidget {
  const _VitaminBGroupRadar({super.key});

  @override
  State<_VitaminBGroupRadar> createState() => _VitaminBGroupRadarState();
}

class _VitaminBGroupRadarState extends State<_VitaminBGroupRadar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var vitaminBGroupDataList =
        context.watch<AnalysisReportStore>().vitaminBGroupDataList;
    var vitaminBGroupDataListLength =
        context.watch<AnalysisReportStore>().vitaminBGroupDataListLength;
    var numberOfFeatures = vitaminBGroupDataListLength;
    print("이거 필수 길이이이이$numberOfFeatures");

    const ticks = [50, 100, 150];

    List<dynamic> dynamicList = vitaminBGroupDataList;
    List<String> features = List<String>.from(
        dynamicList.map((nutrient) => nutrient["nutrientsName"].toString()));

// data 리스트 생성
    List<List<double>> data = [
      dynamicList
          .map((nutrient) => (nutrient["data"]["recommendedIntake"] /
              nutrient["data"]["recommendedIntake"] *
              100 as double))
          .toList(),
      dynamicList.map((nutrient) {
        double value = (nutrient["data"]["userIntake"] /
            nutrient["data"]["recommendedIntake"] *
            100) as double;
        return value > 150 ? 150.0 : value;
      }).toList(),
    ];

    print(data);
    print(features);

    return Container(
      width: screenWidth,
      constraints: BoxConstraints(
        minHeight: 210,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
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
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "비타민 B군 섭취 분석",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "(100%가 권장섭취량입니다.)",
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        "단위 : [%]",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    // color: Colors.white, //배경색
                    child: RadarChart(
                      // 차트 축 간격
                      ticks: ticks,
                      // 비타민 B군 이름
                      features: features,
                      // 비타민 B군 세부 수치
                      data: data,
                      // 데이터 표시 범위 색상 변경 : 리스트 타입으로 색상을 나열
                      graphColors: const [
                        Colors.yellow, // 현재섭취량 빨간색으로 표시
                        Colors.red, // 권장섭취량 노란색으로 표시
                      ],
                      axisColor: Colors.green,
                      // 축 색상 변경
                      outlineColor: Colors.grey,
                      // 차트 테두리 색상 변경
                      // 축 표시 글꼴 색상 변경
                      ticksTextStyle:
                          const TextStyle(color: Colors.green, fontSize: 16),
                      // 피처 표시 글꼴 색상 변경
                      featuresTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      // 축 표시 값 반전 : 기본값 false
                      reverseAxis: false,
                      // 다각형 설정
                      sides: vitaminBGroupDataListLength,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//비타민 B 그룹
class _VitaminBGroup extends StatefulWidget {
  const _VitaminBGroup({super.key});

  @override
  State<_VitaminBGroup> createState() => _VitaminBGroupState();
}

//비타민 B 그룹
class _VitaminBGroupState extends State<_VitaminBGroup> {
  @override
  Widget build(BuildContext context) {
    var vitaminBGroupDataList =
        context.watch<AnalysisReportStore>().vitaminBGroupDataList;
    var listLength =
        context.read<AnalysisReportStore>().vitaminBGroupDataListLength;

    return SingleChildScrollView(
      child: BaseContainerOnlyWidth(
        width: 400,
        child: Column(
          children: [
            Text("필수 영양소 분석"),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listLength ?? 0,
                  itemBuilder: (context, i) {
                    var nutrientsName =
                        vitaminBGroupDataList?[i]?["nutrientsName"] ?? "미표기";
                    var recommendedIntake = vitaminBGroupDataList?[i]?["data"]
                            ?["recommendedIntake"] ??
                        "미표기";
                    var excessiveIntake = vitaminBGroupDataList?[i]?["data"]
                            ?["excessiveIntake"] ??
                        "미표기";
                    var userIntake = vitaminBGroupDataList?[i]?["data"]
                            ?["userIntake"] ??
                        "미표기";
                    var unit =
                        vitaminBGroupDataList?[i]?["data"]?["unit"] ?? "미표기";
                    var intakeDiagnosis = vitaminBGroupDataList?[i]?["data"]
                            ?["intakeDiagnosis"] ??
                        "미표기";

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F6F9),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        width: 300,
                        // height: 120,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$nutrientsName',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: BASIC_BLACK,
                                    ),
                                  ),
                                  nutrientStatus(intakeDiagnosis),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("권장 섭취량 "),
                                      Text("과다 섭취량 "),
                                      Text("현재 섭취량 ")
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("$recommendedIntake $unit"),
                                      Text("$excessiveIntake $unit"),
                                      Text("$userIntake $unit"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

//영양소 과다부족적절 상태
Container nutrientStatus(String intakeDiagnosis) {
  var status = intakeDiagnosis;

  if (status == "적절") {
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
        "적절",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  } else if (status == "부족") {
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
        "부족",
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
        "주의",
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

//추천 리스트
class _RecommendList extends StatefulWidget {
  const _RecommendList({super.key});

  @override
  State<_RecommendList> createState() => _RecommendListState();
}

//추천 리스트
class _RecommendListState extends State<_RecommendList> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var recommendList = context.watch<AnalysisReportStore>().recommendList;
    var listLength = context.read<AnalysisReportStore>().recommendListLength;
    var userDetailInfo = context.watch<UserStore>().UserDetail;

    print("이게 추천길이 $listLength");
    print(recommendList);

    return Container(
      width: screenWidth,
      constraints: BoxConstraints(
        minHeight: 210,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
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
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Pillin이 ${userDetailInfo?['name'] ?? 0}님에게",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "추천하는 영양제 리스트",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "(부족한 영양소에 대한 추천 영양제입니다.)",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: listLength ?? 0,
                        itemBuilder: (context, int index) {
                          var nutrientsName =
                              recommendList[index]["nutritionName"] ?? "미표기";
                          List recommendOneData =
                              recommendList[index]["data"] ?? "미표기";
                          var recommendOneDataLength = recommendOneData.length;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  // Text(
                                  //   "인기",
                                  //   style: TextStyle(fontSize: 20),
                                  // ),
                                  Text(
                                    " $nutrientsName ",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.redAccent),
                                  ),
                                  Text(
                                    "포함된 인기 영양제",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                child: CarouselSlider.builder(
                                  itemCount: recommendOneDataLength ?? 0,
                                  options: CarouselOptions(
                                    height: 400,
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  itemBuilder:
                                      (context, int index, int realIndex) {
                                    var pillId = recommendOneData[index]
                                            ["pillId"] ??
                                        "미표기";
                                    var rank =
                                        recommendOneData[index]["rank"] + 1 ??
                                            "미표기";
                                    var pillName = recommendOneData[index]
                                            ["pillName"] ??
                                        "미표기";
                                    var manufacturer = recommendOneData[index]
                                            ["manufacturer"] ??
                                        "미표기";
                                    var imageUrl = recommendOneData[index]
                                            ["imageUrl"] ??
                                        "미표기";

                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border: Border.all(
                                            width: 3,
                                            color: Colors.grey,
                                          )),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "$rank 위 (Pillin 사용자 기준)",
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            child: Image.network(
                                              imageUrl,
                                              width: 200,
                                              // height: 200,
                                            ),
                                          ),
                                          Text(
                                            manufacturer,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Container(
                                            width: 150,
                                            child: RichText(
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                text: TextSpan(
                                                    text: pillName,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ))),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<SearchStore>()
                                                      .pillDetailData;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PillDetailScreen(
                                                                pillId: pillId,
                                                              )));
                                                  context
                                                      .read<SearchStore>()
                                                      .pillDetailData;
                                                },
                                                child: const Text(
                                                  '상세 보기',
                                                ),
                                              ),
                                              ElevatedButton(
                                                child: const Text('구매하기'),
                                                onPressed: () async {
                                                  context
                                                      .read<SearchRepository>()
                                                      .getNaverBlogSearch(
                                                          pillName);
                                                  var buyLink = context
                                                      .read<SearchRepository>()
                                                      .BuyLink;
                                                  print(buyLink);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
