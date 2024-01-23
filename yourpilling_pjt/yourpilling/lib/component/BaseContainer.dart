import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  final double width, height;
  final Widget child;
  const BaseContainer({super.key, required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {

    return Container (
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
          BoxShadow(
            color: Color(0x00b5b5b5).withOpacity(0.1),
            offset: Offset(0.1, 0.2),
            blurRadius: 4// 그림자 위치 조정
          ),
        ]
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
