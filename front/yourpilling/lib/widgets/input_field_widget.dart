import 'package:flutter/material.dart';

import '../const/colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 20),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: obscureText,
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: fontFamily,
        ),
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
          focusColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontFamily: fontFamily,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          contentPadding: EdgeInsets.only(top: 15),
        ),
      ),
    );
  }
}