import 'package:flutter/material.dart';

class GenericBottomNavigatorBarProvider extends ChangeNotifier {
  int _currentPage = 1;
  int get currentPage => _currentPage;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}
