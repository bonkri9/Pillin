import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/common/app_bar.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/Search/search_list_screen.dart';
import '../../component/common/base_container.dart';
import 'package:http/http.dart' as http;
import '../../store/search_store.dart';
import '../../store/user_store.dart';


class SearchNutrientScreen extends StatefulWidget {
  const SearchNutrientScreen({super.key});

  @override
  State<SearchNutrientScreen> createState() => _SearchNutrientScreenState();
}

class _SearchNutrientScreenState extends State<SearchNutrientScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();
  final String selectNutrient = '';

  _SearchNutrientScreenState() {
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
          title: _SearchBar(
            myController: myController,
          ),
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
                  child: Text("인기 성분이에요" ,style: TextStyle(
                    fontSize: 18.5,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w700,
                  ),),
                ),
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



// 검색바
class _SearchBar extends StatelessWidget {
  final TextEditingController myController;

  const _SearchBar({Key? key, required this.myController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.start, // 텍스트 왼쪽 정렬
                controller: myController,
                decoration: InputDecoration(
                  filled: false,
                  hintText: '성분 이름을 입력해주세요',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFFFF6F61),
                size: 34,
              ),
              onPressed: () async {
                try {
                  await context.read<SearchStore>().getSearchNameData(
                    context,
                    myController.text,
                  );
                  print('검색 통신 성공');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchListScreen(
                        myControllerValue: myController.text,
                      ),
                    ),
                  );
                } catch (error) {
                  print('이름 검색 실패');
                  falseDialog(context);
                  print(error);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


// 중간탭
class _MiddleTab extends StatelessWidget {
  const _MiddleTab({super.key});

  @override
  Widget build(BuildContext context) {
    String accessToken = context.read<UserStore>().accessToken;
    var nutrientList = [
      {
        'nutrient': '비타민C', // 영양제 이름
      },
      {
        'nutrient': '비타민A', // 영양제 이름
      },
      {
        'nutrient': '비타민B1', // 영양제 이름
      },
      {
        'nutrient': '비타민B2', // 영양제 이름
      },
      {
        'nutrient': '비타민B3', // 영양제 이름
      },
      {
        'nutrient': '비타민B6', // 영양제 이름
      },
      {
        'nutrient': '비타민B12', // 영양제 이름
      },
      {
        'nutrient': '비타민D', // 영양제 이름
      },
      {
        'nutrient': '비타민E', // 영양제 이름
      },
      {
        'nutrient': '비타민K', // 영양제 이름
      },
      {
        'nutrient': '칼슘', // 영양제 이름
      },
      {
        'nutrient': '칼륨', // 영양제 이름
      },
      {
        'nutrient': '마그네슘', // 영양제 이름
      },
      {
        'nutrient': '망간', // 영양제 이름
      },
      {
        'nutrient': '셀레늄', // 영양제 이름
      },
      {
        'nutrient': '엽산', // 영양제 이름
      },
      {
        'nutrient': '아미노산', // 영양제 이름
      },
      {
        'nutrient': '판토텐산', // 영양제 이름
      },
      {
        'nutrient': '비오틴', // 영양제 이름
      },
      {
        'nutrient': '철분', // 영양제 이름
      },
      {
        'nutrient': '오메가3',
      },
      {
        'nutrient': '크롬', // 영양제 이름
      },
    ];

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        children: nutrientList.map((nutrient) {
          return Padding(
            padding: const EdgeInsets.all(9),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.1),
                border: Border.all(
                  width: 0.2,
                  color: BASIC_GREY.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              width: 50,
              height: 50,
              child: TextButton(
                onPressed: () async {
                  print(nutrient['nutrient']!);
                  await context.read<SearchStore>().getSearchNutrientData(context, nutrient['nutrient']!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchListScreen(
                              myControllerValue: nutrient['nutrient']!)));
                },
                child: Text(nutrient['nutrient']!, style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w400,
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
              const Text("성분 검색결과가 없습니다."),
            ],
          ),
        ),
      );
    },
  );
}