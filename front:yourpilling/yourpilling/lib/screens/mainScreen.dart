import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({
    required this.child,
    Key? key,
  }) : super(key: key);

  int getIndex(BuildContext context){
    if(GoRouterState.of(context).location == '/MainPage/a'){
      return 0;
    }else if(GoRouterState.of(context).location == '/MainPage/b'){
      return 1;
    }else{
      return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${GoRouterState.of(context).location}'),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: getIndex(context),
        onTap: (index){
          if(index == 0){
            context.go('/MainPage/a');
          }else if(index == 1){
            context.go('/MainPage/b');
          }else {
            context.go('/MainPage/c');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'MainPage1',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'MainPage2',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: 'MyPage',
          ),
        ],
      ),
    );
  }
}