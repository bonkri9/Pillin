import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:provider/provider.dart';

import '../../component/common/base_container_noheight.dart';
import '../../const/colors.dart';
import '../../store/analysis_report_store.dart';
import '../../store/search_store.dart';
import '../Search/search_pill_detail.dart';

class AnalysisReport extends StatefulWidget {
  const AnalysisReport({super.key});

  @override
  State<AnalysisReport> createState() => _AnalysisReportState();
}

class _AnalysisReportState extends State<AnalysisReport> {
  @override
  Widget build(BuildContext context) {
    context.read<AnalysisReportStore>().getEssentialNutrientsDataList(context);
    context.read<AnalysisReportStore>().getVitaminBGroupDataList(context);
    context.read<AnalysisReportStore>().getRecommendList(context);

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text("나의 분석 리포트"),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              _EssentialNutrients(),
              _VitaminBGroupRadar(),
              _VitaminBGroup(),
              _RecommendList(),
            ],
          ),
        ),
      ),
    );
  }
}

//필수영양소
class _EssentialNutrients extends StatefulWidget {
  const _EssentialNutrients({super.key});

  @override
  State<_EssentialNutrients> createState() => _EssentialNutrientsState();
}

class _EssentialNutrientsState extends State<_EssentialNutrients> {
  bool darkMode = false;
  bool useSides = false;

  @override
  Widget build(BuildContext context) {
    var essentialNutrientDataList =
        context.watch<AnalysisReportStore>().essentialNutrientDataList;
    var essentialNutrientDataLisLength =
        context.read<AnalysisReportStore>().essentialNutrientDataLisLength;
    var numberOfFeatures = essentialNutrientDataLisLength;
    print("이거 필수 길이이이이$numberOfFeatures");

    const ticks = [50, 100, 150];

    List<dynamic> dynamicList = essentialNutrientDataList;
    List<String> features = List<String>.from(
        dynamicList.map((nutrient) => nutrient["nutrientsName"].toString()));

// data 리스트 생성
    List<List<double>> data = dynamicList
        .map((nutrient) => [
              (nutrient["data"]["recommendedIntake"] /
                  nutrient["data"]["recommendedIntake"] *
                  100 as double),
              (nutrient["data"]["userIntake"] /
                  nutrient["data"]["recommendedIntake"] *
                  100 as double),
            ])
        .toList();

    print(data);
    print(features);

    // features = features.sublist(0, numberOfFeatures.floor());
    // data = data
    //     .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
    //     .toList();

    // bool darkMode = false;
    // bool useSides = false;
    // double numberOfFeatures = essentialNutrientDataLisLength;

    return Container(
      width: 350,
      height: 350,
      color: Colors.white,
      child: RadarChart(
        ticks: ticks,
        // 차트 축 간격
        features: features,
        // 각각의 데이터 이름
        data: data,
        // 각 데이터 이름의 세부 수치
        // 데이터 표시 범위 색상 변경 : 리스트 타입으로 색상을 나열
        graphColors: const [
          Colors.red, // 첫 번째 피처 데이터는 빨간색으로 표시
          Colors.yellow, // 두 번째 피처 데이터는 노란색으로 표시
        ],
        axisColor: Colors.green,
        // 축 색상 변경
        outlineColor: Colors.blue,
        // 차트 테두리 색상 변경
        // 축 표시 글꼴 색상 변경
        ticksTextStyle: const TextStyle(color: Colors.green, fontSize: 16),
        // 피처 표시 글꼴 색상 변경
        featuresTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        // 축 표시 값 반전 : 기본값 false
        reverseAxis: false,
        // 다각형 설정
        sides: essentialNutrientDataLisLength,
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
  bool darkMode = false;
  bool useSides = false;

  @override
  Widget build(BuildContext context) {
    var vitaminBGroupDataList =
        context.watch<AnalysisReportStore>().vitaminBGroupDataList;
    var vitaminBGroupDataListLength =
        context.read<AnalysisReportStore>().vitaminBGroupDataListLength;
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
      dynamicList
          .map((nutrient) => (nutrient["data"]["userIntake"] /
              nutrient["data"]["recommendedIntake"] *
              100 as double))
          .toList()
    ];

    print(data);
    print(features);

    // features = features.sublist(0, numberOfFeatures.floor());
    // data = data
    //     .map((graph) => graph.sublist(0, numberOfFeatures.floor()))
    //     .toList();

    // bool darkMode = false;
    // bool useSides = false;
    // double numberOfFeatures = essentialNutrientDataLisLength;

    return Column(
      children: [
        Row(
          children: [
            Text(
              "비타민 B군 섭취 분석",
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
        Container(
          width: 350,
          height: 350,
          color: Colors.white,
          child: RadarChart(
            ticks: ticks,
            // 차트 축 간격
            features: features,
            // 각각의 데이터 이름
            data: data,
            // 각 데이터 이름의 세부 수치
            // 데이터 표시 범위 색상 변경 : 리스트 타입으로 색상을 나열
            graphColors: const [
              Colors.red, // 첫 번째 피처 데이터는 빨간색으로 표시
              Colors.yellow, // 두 번째 피처 데이터는 노란색으로 표시
            ],
            axisColor: Colors.green,
            // 축 색상 변경
            outlineColor: Colors.blue,
            // 차트 테두리 색상 변경
            // 축 표시 글꼴 색상 변경
            ticksTextStyle: const TextStyle(color: Colors.green, fontSize: 16),
            // 피처 표시 글꼴 색상 변경
            featuresTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            // 축 표시 값 반전 : 기본값 false
            reverseAxis: false,
            // 다각형 설정
            sides: vitaminBGroupDataListLength,
          ),
        ),
      ],
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
  var _current = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    var recommendList = context.watch<AnalysisReportStore>().recommendList;
    var listLength = context.read<AnalysisReportStore>().recommendListLength;
    print("이게 추천길이 $listLength");
    print(recommendList);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: listLength ?? 0,
          itemBuilder: (context, int index) {
            var nutrientsName = recommendList[index]["nutritionName"] ?? "미표기";
            List recommendOneData = recommendList[index]["data"] ?? "미표기";
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
                      style: TextStyle(fontSize: 30, color: Colors.redAccent),
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
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemBuilder: (context, int index, int realIndex) {
                      var pillId = recommendOneData[index]["pillId"] ?? "미표기";
                      var rank = recommendOneData[index]["rank"] + 1 ?? "미표기";
                      var pillName =
                          recommendOneData[index]["pillName"] ?? "미표기";
                      var manufacturer =
                          recommendOneData[index]["manufacturer"] ?? "미표기";
                      var imageUrl =
                          recommendOneData[index]["imageUrl"] ?? "미표기";

                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
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
                                // Text(
                                //   // "$rank 위 (Pillin 사용자 기준)",
                                //   textAlign: TextAlign.start,
                                // ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.network(
                                imageUrl,
                                width: 200,
                                // height: 200,
                              ),
                            ),
                            Text(
                              manufacturer,
                              style: TextStyle(color: Colors.grey),
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
                                        fontWeight: FontWeight.w600,
                                      ))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<SearchStore>().PillDetailData;
                                    Navigator.push(

                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PillDetailScreen(
                                                  pillId: pillId,
                                                )));
                                    context.read<SearchStore>().PillDetailData;
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
                                        .getNaverBlogSearch(pillName);
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
    );
  }
}

//return Container(
//       color: darkMode ? Colors.black : Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 darkMode
//                     ? Text(
//                         'Light mode',
//                         style: TextStyle(color: Colors.white),
//                       )
//                     : Text(
//                         'Dark mode',
//                         style: TextStyle(color: Colors.black),
//                       ),
//                 Switch(
//                   value: this.darkMode,
//                   onChanged: (value) {
//                     setState(() {
//                       darkMode = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 useSides
//                     ? Text(
//                         'Polygon border',
//                         style: darkMode
//                             ? TextStyle(color: Colors.white)
//                             : TextStyle(color: Colors.black),
//                       )
//                     : Text(
//                         'Circular border',
//                         style: darkMode
//                             ? TextStyle(color: Colors.white)
//                             : TextStyle(color: Colors.black),
//                       ),
//                 Switch(
//                   value: this.useSides,
//                   onChanged: (value) {
//                     setState(() {
//                       useSides = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Text(
//                   'Number of features',
//                   style:
//                       TextStyle(color: darkMode ? Colors.white : Colors.black),
//                 ),
//                 Expanded(
//                   child: Slider(
//                     value: numberOfFeatures,
//                     min: 3,
//                     max: 8,
//                     divisions: 5,
//                     onChanged: (value) {
//                       setState(() {
//                         numberOfFeatures = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: darkMode
//                 ? RadarChart.dark(
//                     ticks: ticks,
//                     features: features,
//                     data: data,
//                     reverseAxis: true,
//                     useSides: useSides,
//                   )
//                 : RadarChart.light(
//                     ticks: ticks,
//                     features: features,
//                     data: data,
//                     reverseAxis: true,
//                     useSides: useSides,
//                   ),
//           ),
//         ],
//       ),
//     );
