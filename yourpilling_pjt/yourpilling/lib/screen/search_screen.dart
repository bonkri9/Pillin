import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';
import 'package:yourpilling/screen/search_health_screen.dart';
import 'package:yourpilling/screen/search_list_screen.dart';
import 'package:yourpilling/screen/search_nutrient_screen.dart';
import '../component/BaseContainer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // TextEditingController를 생성하여 TextField에 사용자의 입력을 관리합니다.
  final myController = TextEditingController();

  _SearchScreenState() {
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
        body:
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _SearchBar(myController: myController,),
            _MiddleTap(),
            _Ranking(),
            // 랭킹페이지
          ],
        ),
      ),
    );

  }
}



// 검색바
class _SearchBar extends StatelessWidget {
  final TextEditingController myController;

  const _SearchBar({Key? key, required this.myController}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // TextField 위젯을 추가합니다.
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: '검색어를 입력하세요',
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.search, color: Color(0xFFFF6666)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchListScreen()));
              }),
        ],
      ),
    );
  }
}



// 성분 검색, 건강 검색
class _MiddleTap extends StatelessWidget {
  const _MiddleTap({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20,),
        BaseContainer(
          width: 180,
          height: 180,
          child: TextButton(
            onPressed: () {
              // TextField에 입력된 텍스트를 출력합니다.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchNutrientScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("성분검색",
                    style:
                    TextStyle(color: LIGHT_BLACK, fontSize: 30)),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        BaseContainer(
          width: 180,
          height: 180,
          child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchHealthScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("건강 검색",
                    style:
                    TextStyle(color: LIGHT_BLACK, fontSize: 30)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 랭킹페이지
class _Ranking extends StatelessWidget {
  const _Ranking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      width: 350,
      height: 500,
      child: DefaultTabController(
        length: 3, // 탭의 수
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "영양제 랭킹",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30.5,
                      color: BASIC_BLACK,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Inventory()));
                    },
                    icon: Icon(Icons.arrow_forward_ios, size: 15),
                  ),
                ],
              ),
            ),
            // header end
            TabBar(
              tabs: [
                Tab(text: '20대 추천'),
                Tab(text: '성분'),
                Tab(text: '건강 고민'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _AgeTab(),
                  _NutrientTab(),
                  _HealthTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// 나이 탭
class _AgeTab extends StatefulWidget {
  const _AgeTab({super.key});

  @override
  State<_AgeTab> createState() => _AgeTabState();
}
class _AgeTabState extends State<_AgeTab> {
  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7, // 배열의 길이로 할당해야겠네
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('종합비타민 ${i}'),
                );
              },
            ),
          ),
          _showText ? Expanded(child: _SearchRanking(title: '${_index}',)) : Expanded(child: Text('버튼 누르세용')),
        ],
      ),
    );
  }
}

// 성분 탭
class _NutrientTab extends StatefulWidget {
  const _NutrientTab({super.key});

  @override
  State<_NutrientTab> createState() => _NutrientTabState();
}
class _NutrientTabState extends State<_NutrientTab> {
  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7, // 배열의 길이로 할당해야겠네
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('마그네슘 ${i}'),
                );
              },
            ),
          ),
          _showText ? Expanded(child: _SearchRanking(title: '${_index}',)) : Expanded(child: Text('버튼 누르세용')),
        ],
      ),
    );
  }
}

// 건강고민 탭


class _HealthTab extends StatefulWidget {
  const _HealthTab({super.key});

  @override
  State<_HealthTab> createState() => _HealthTabState();
}
class _HealthTabState extends State<_HealthTab> {
  bool _showText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 50, // 높이 설정
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7, // 배열의 길이로 할당해야겠네
              itemBuilder: (context, i) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _showText = true;
                      _index = i;
                    });
                  },
                  child: Text('눈건강 ${i}'),
                );
              },
            ),
          ),
          _showText ? Expanded(child: _SearchRanking(title: '${_index}',)) : Expanded(child: Text('버튼 누르세용')),
        ],
      ),
    );
  }
}


class _SearchRanking extends StatelessWidget {
  final String title; // 문자열 매개변수 추가

  const _SearchRanking({Key? key, required this.title}) : super(key: key); // 생성자에서 문자열 매개변수를 필수로 받도록 설정

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 18,
        itemBuilder: (context, i) {
          return Row(
            children: [
              SizedBox(width: 10,),
              Image.asset(
                'assets/image/${i+1}.png',
                height: 30.0,
                width: 30.0,
              ),
              Image.asset("assets/image/비타민B.jpg", width: 110, height: 80,),
              Text(title, // 전달받은 문자열 사용
                style: TextStyle(
                  fontSize: 10,
                  color: BASIC_BLACK,
                ),
              ),
              Text("비타민${i+1}",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.green,
                ),
              ),
            ],
          );
        }
    );
  }
}