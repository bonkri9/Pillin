import 'package:flutter/material.dart';

class UserStore extends ChangeNotifier {
  var accessToken = '';

  String get loginToken => accessToken;
  bool get isLoggedIn => accessToken.isNotEmpty;


  getToken(String token) {
    accessToken = token;
    notifyListeners();
  }
}