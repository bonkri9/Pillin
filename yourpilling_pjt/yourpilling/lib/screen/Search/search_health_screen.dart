import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Search/search_list_screen.dart';
import '../../component/common/app_bar.dart';
import '../../component/common/base_container.dart';
import 'package:http/http.dart' as http;
import '../../store/search_store.dart';
import '../../store/user_store.dart';


class SearchHealthScreen extends StatefulWidget {
  const SearchHealthScreen({super.key});

  @override
  State<SearchHealthScreen> createState() => _SearchHealthScreenState();
}

class _SearchHealthScreenState extends State<SearchHealthScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();

  _SearchHealthScreenState() {
    myController.addListener(() {
      print("TextField content: ${myController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 터치하면 키보드꺼짐
      },
      child: Scaffold(
        appBar: MainAppBar(
          barColor: Color(0xFFF5F6F9),
        ),
        backgroundColor: BACKGROUND_COLOR,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _SearchBar(
              //   myController: myController,
              // ),
              _MiddleTab(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 컨트롤러를 정리해주는 작업입니다.
    myController.dispose();
    super.dispose();
  }
}
//
// // 검색바
// class _SearchBar extends StatelessWidget {
//   final TextEditingController myController;
//
//   const _SearchBar({Key? key, required this.myController}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 30,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Expanded(
//             child: TextField(
//               controller: myController,
//               decoration: InputDecoration(
//                 labelText: '건강고민을 검색하세요',
//                 hoverColor: BASIC_GREY,
//               ),
//             ),
//           ),
//           IconButton(
//               icon: Icon(
//                 Icons.search,
//                 color: Color(0xFFFF6666),
//                 size: 34,
//               ),
//               onPressed: () async {
//                 try{
//                   await context.read<SearchStore>().getSearchHealthData(context, myController.text);
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => SearchListScreen(
//                             myControllerValue: myController.text,
//                           )));
//                 }catch(error){
//                   falseDialog(context);
//                 }
//
//               }),
//         ],
//       ),
//     );
//   }
// }

// 중간탭
class _MiddleTab extends StatelessWidget {
  _MiddleTab({super.key});

  @override
  Widget build(BuildContext context) {
    var healthList = [
      {
        'health': '치아/뼈 건강',
        'id' : 1
      },
      {
        'health': '어린이',
        'id' : 2
      },
      {
        'health': '여성 건강',
        'id' : 3
      },
      {
        'health': '남성 건강',
        'id' : 4
      },
      {
        'health': '위장/배뇨',
        'id' : 5
      },
      {
        'health': '피로/간',
        'id' : 6
      },
      {
        'health': '피부 건강',
        'id' : 8
      },
      {
        'health': '기억력 개선',
        'id' : 8
      },
      {
        'health': '눈 건강',
        'id' : 9},
      {
        'health': '혈압,혈당,형행',
        'id' : 10
      },
      {
        'health': '다이어트',
        'id' : 11
      },
      {
        'health': '임산부',
        'id' : 12
      },
      {
        'health': '스트레스/수면',
        'id' : 13
      },
      {
        'health': '면역/향산화',
        'id' : 14
      },
      {
        'health': '탈모',
        'id' : 15
      },
    ];

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: healthList.map((health) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Stack(children: [
              Positioned(
                top: 0,
                left: 15,

                child: BaseContainer(
                  color: Colors.white,

                  width: 100,
                  height: 100,
                  child: TextButton(
                    onPressed: () async {
                      try{
                        print('체크 건강사항 ${health['health']}');
                        print('체크 건강번호 ${health['id']}');
                        await context.read<SearchStore>().getSearchHealthData(context, health['id'].toString()!);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchListScreen(
                                    myControllerValue: health['health'].toString()!)));
                      }catch(error){
                        falseDialog(context);
                      }

                    },
                    child: Text(health['health'].toString()!),
                  ),
                ),
              ),

            ]),
          );
        }).toList(),
      ),
    );
  }
}


// 통신 오류
void falseDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          width: 200,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("건강 검색결과가 없습니다."),
            ],
          ),
        ),
      );
    },
  );
}