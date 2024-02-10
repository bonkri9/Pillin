import 'package:flutter/material.dart';
import 'package:yourpilling/const/colors.dart';

class BaseContainerOnlyWidth extends StatelessWidget {
  final double width;
  final Widget child;
  const BaseContainerOnlyWidth({super.key, required this.width, required this.child});

  @override
  Widget build(BuildContext context) {

    return Container (
      height: 200,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            width: 0.1,
            color: Colors.grey.withOpacity(0.5),
          ),
          boxShadow: [
          BoxShadow(
            color: Color(0x00b5b5b5).withOpacity(0.1),
            offset: Offset(0.1, 0.1),
            blurRadius: 3// 그림자 위치 조정
          ),
        ]
      ),
      width: width,
      child: child,
    );
  }
}
