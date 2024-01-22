import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yourpilling/route/router.dart';

import '../layout/defaultLayout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool authState = false;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Center(
        child: ListView(
          children: [
            Text('Login State : $authState'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: "ID",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // 비밀번호를 숨김처리합니다.
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  authState = !authState;
                });
              },
              child: Text(
                authState ? 'logout' : 'login',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/MainPage/a');
              },
              child: Text('Go MainPage'),
            ),
          ],
        ),
      ),
    );
  }
}
