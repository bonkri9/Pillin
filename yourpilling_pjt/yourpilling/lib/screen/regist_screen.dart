import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistScreen extends StatelessWidget {
  const RegistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(

        children: [
          Text('회원가입 정보 받아야함'),
          ElevatedButton(
            onPressed: () {
              context.go('/MainPage/a');
            },
            child: Text('Go MainPage'),
          ),
        ],),
      )
    );
  }
}