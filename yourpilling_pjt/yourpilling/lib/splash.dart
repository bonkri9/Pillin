import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yourpilling/screen/Main/main_page_child_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final Condition = false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      if(Condition){
        exit(0);
      }
      else{
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => MainPageChild()
        )
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final String imageLogoName = 'assets/logo/pillin_logo.png';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:1.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imageLogoName,
                width: 400,
              ),
              Text("© Copyright 2024, Pillin",
                  style: TextStyle(color: Colors.black)
              ),

            ],
          ),
        ),
      ),
    );
  }
}
