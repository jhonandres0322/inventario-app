import 'package:flutter/material.dart';

abstract class ListProviderUtil with ChangeNotifier {
  int _page = 0;
  bool _isLoading = true;
  bool _isRefresh = false;

  bool get isRefresh => _isRefresh;
  bool get isLoading => _isLoading;
  int get page => _page;

  set isRefresh(bool value) {
    _isRefresh = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set page(int value) {
    _page = value;
    notifyListeners();
  }
}
