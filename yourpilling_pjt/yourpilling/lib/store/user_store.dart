import 'package:flutter/material.dart';

class UserStore extends ChangeNotifier {
  String accessToken = 'Bearer ...';

  getToken(String token) {
    accessToken = token;
    notifyListeners();
  }
}