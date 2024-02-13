import 'package:flutter/material.dart';

class AngleContainer extends StatelessWidget {
  final double width, height;
  final Widget child;
  const AngleContainer({super.key, required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {

    return Container (
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: Offset(0.1, 0.1),
            blurRadius: 1// 그림자 위치 조정
          ),
        ]
      ),
      width: width,
      height: height,
      child: child,
    );
  }
}
