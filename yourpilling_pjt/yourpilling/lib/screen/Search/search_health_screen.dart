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
    var screenWidth = MediaQuery.of(context).size.width * 0.91;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 터치하면 키보드꺼짐
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              // 뒤로 가기 기능 추가
              Navigator.pop(context);
            },
          ),
          toolbarHeight: 70,
          // title: _SearchBar(
          //   myController: myController,
          // ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("어떤 건강고민을 하고 계신가요?" ,style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w700,
                  ),),
                ),
                SizedBox(height: 25,),
                _MiddleTab(),
              ],
            ),
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
            padding: const EdgeInsets.all(9),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.1),
                border: Border.all(
                  width: 0.2,
                  color: BASIC_GREY.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
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
                child: Text(health['health'].toString(), style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  color: BASIC_BLACK.withOpacity(0.8),
                ),),
              ),
            ),
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