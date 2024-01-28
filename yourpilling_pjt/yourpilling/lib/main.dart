import 'package:flutter/material.dart';
import 'package:yourpilling/screen/main_page_child_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(SafeArea(
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: "Pretendard",
          ),
          debugShowCheckedModeBanner: false,
          home: MainPageChild()))));
}
