import 'package:flutter/material.dart';

import '../const/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          constraints: const BoxConstraints(maxHeight: 60),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
