import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('소개페이지입니다'),ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: Text('Login Screen'),
          ),

          ElevatedButton(
            onPressed: () {
              context.go('/regist');
            },
            child: Text('Regist Screen'),
          ),
        ],
      ),
    );
  }
}
