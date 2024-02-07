import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourpilling/component/app_bar.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
import '../component/base_container.dart';
import 'package:http/http.dart' as http;
import '../store/search_store.dart';
import '../store/user_store.dart';


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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 터치하면 키보드꺼짐
      },
      child: Scaffold(
        appBar: MainAppBar(
          barColor: Color(0xFFF5F6F9),
        ),
        backgroundColor: BACKGROUND_COLOR,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SearchBar(
              myController: myController,
            ),
            _MiddleTab(),
          ],
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: '영양소 검색',
                hoverColor: BASIC_GREY,
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xFFFF6666),
                size: 34,
              ),
              onPressed: () async {
                try{
                  await context.read<SearchStore>().getSearchNutrientData(context, myController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchListScreen(
                            myControllerValue: myController.text,
                          )));
                }catch(error){
                  falseDialog(context);
                }

              }),
        ],
      ),
    );
  }
}

// 중간탭
class _MiddleTab extends StatelessWidget {
  const _MiddleTab({super.key});

  @override
  Widget build(BuildContext context) {
    String accessToken = context.watch<UserStore>().accessToken;
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
        'nutrient': '칼슐', // 영양제 이름
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
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: BaseContainer(
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
                child: Text(nutrient['nutrient']!),
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