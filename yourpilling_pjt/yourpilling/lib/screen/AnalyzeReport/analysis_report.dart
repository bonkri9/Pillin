import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../component/common/base_container_noheight.dart';
import '../../const/colors.dart';
import '../../store/analysis_report_store.dart';

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
              _VitaminBGroup(),
              _RecommendList(),
            ],
          ),
        ),
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

//추천리스트
// class _RecommendList extends StatefulWidget {
//   const _RecommendList({super.key});
//
//   @override
//   State<_RecommendList> createState() => _RecommendListState();
// }
//
// class _RecommendListState extends State<_RecommendList> {
//   var _current = 0;
//   CarouselController carouselController = CarouselController();
//
//   @override
//   Widget build(BuildContext context) {
//     var recommendList = context.watch<AnalysisReportStore>().recommendList;
//     var listLength = context.read<AnalysisReportStore>().recommendListLength;
//     print("이게 추천길이 $listLength");
//     print(recommendList);
//
//     return ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: listLength ?? 0,
//         itemBuilder: (context, int index) {
//           var nutrientsName = recommendList[index]["nutrientsName"] ?? "미표기";
//           List recommendOneData = recommendList[index]["data"] ?? "미표기";
//           var recommendOneDataLength = recommendOneData.length;
//
//           return Column(
//             children: [
//               ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   itemCount: recommendOneDataLength ?? 0,
//                   itemBuilder: (context, int index) {
//                     var pillId = recommendOneData[index]["pillId"] ?? "미표기";
//                     var rank = recommendOneData[index]["rank"] ?? "미표기";
//                     var pillName = recommendOneData[index]["pillName"] ?? "미표기";
//                     var manufacturer =
//                         recommendOneData[index]["manufacturer"] ?? "미표기";
//                     var imageUrl = recommendOneData[index]["imageUrl"] ?? "미표기";
//
//                     return Center(
//                       child: CarouselSlider(
//                         options: CarouselOptions(
//                           autoPlay: false,
//                         ),
//                         items: recommendOneData.map((item) {
//                           return Builder(builder: (BuildContext context) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(16.0),
//                                   border: Border.all(
//                                     width: 3,
//                                     color: Colors.grey,
//                                   )),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(16.0),
//                                 child:
//                                     Image.network(imageUrl, fit: BoxFit.fill),
//                               ),
//                             );
//                           });
//                         }).toList(),
//                       ),
//                     );
//                   }),
//             ],
//           );
//         });
//   }
// }

class _RecommendList extends StatefulWidget {
  const _RecommendList({super.key});

  @override
  State<_RecommendList> createState() => _RecommendListState();
}

class _RecommendListState extends State<_RecommendList> {
  var _current = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    var recommendList = context.watch<AnalysisReportStore>().recommendList;
    var listLength = context.read<AnalysisReportStore>().recommendListLength;
    print("이게 추천길이 $listLength");
    print(recommendList);

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: listLength ?? 0,
        itemBuilder: (context, int index) {
          var nutrientsName = recommendList[index]["nutrientsName"] ?? "미표기";
          List recommendOneData = recommendList[index]["data"] ?? "미표기";
          var recommendOneDataLength = recommendOneData.length;

          var pillId = recommendOneData[index]["pillId"] ?? "미표기";
          var rank = recommendOneData[index]["rank"] ?? "미표기";
          var pillName = recommendOneData[index]["pillName"] ?? "미표기";
          var manufacturer = recommendOneData[index]["manufacturer"] ?? "미표기";
          var imageUrl = recommendOneData[index]["imageUrl"] ?? "미표기";

          return Center(
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: false,
              ),
              items: recommendOneData.map((item) {
                // var pillId = recommendOneData[index]["pillId"] ?? "미표기";
                // var rank = recommendOneData[index]["rank"] ?? "미표기";
                // var pillName = recommendOneData[index]["pillName"] ?? "미표기";
                // var manufacturer = recommendOneData[index]["manufacturer"] ?? "미표기";
                // var imageUrl = recommendOneData[index]["imageUrl"] ?? "미표기";

                return Builder(builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          width: 3,
                          color: Colors.grey,
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(imageUrl, fit: BoxFit.fill),
                    ),
                  );
                });
              }).toList(),
            ),
          );
        });
  }
}
