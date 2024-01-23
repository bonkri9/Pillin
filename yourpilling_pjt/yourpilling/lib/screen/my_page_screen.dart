
import 'package:flutter/material.dart';
import 'package:yourpilling/component/login/login_main.dart';
import 'package:yourpilling/component/login/sign_up_screen.dart';
import '../component/login/login2_screen.dart';
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // child: Text("하이"),
        child: Row(
          children: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginMain()));
            },
                icon: Icon(Icons.login, size: 50,),
            ),
            // IconButton(onPressed: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
            // },
            //   icon: Icon(Icons.assignment_ind_outlined, size: 50,),
            // ),
          ],
        ),
      )
    );
  }
}
