import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabsNavigator with ChangeNotifier {
  int _actual = 0;

  int get actualPage => _actual;

  set actualPage(int page) {
    _actual = page;
    notifyListeners();
  }
}
