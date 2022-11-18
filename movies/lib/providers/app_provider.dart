import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool theme = false;

  changeTheme() {
    theme = !theme;

    notifyListeners();
  }
}
