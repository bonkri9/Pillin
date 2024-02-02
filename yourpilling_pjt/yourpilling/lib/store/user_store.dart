import 'package:flutter/material.dart';

class UserStore extends ChangeNotifier {
  var accessToken = 'Bearer ...';

  getToken(String token) {
    accessToken = token;
    notifyListeners();
  }
}