import 'package:flutter/material.dart';

class GenericSaveProvider<T> extends ChangeNotifier {
  bool _loading = false;
  String? _error;
  String? _success;
  T? _saved;
  bool _showSuccess = false;
  bool _showError = false;

  bool get loading => _loading;
  String? get error => _error;
  String? get success => _success;
  T? get saved => _saved;
  bool get showSuccess => _showSuccess;
  bool get showError => _showError;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set saved(T? value) {
    _saved = value;
    notifyListeners();
  }

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  set success(String? value) {
    _success = value;
    notifyListeners();
  }

  set showSuccess(bool value) {
    _showSuccess = value;
    notifyListeners();
  }

  set showError(bool value) {
    _showError = value;
    notifyListeners();
  }

  void resetState() {
    _saved = null;
    _error = null;
    _success = null;
    _showSuccess = false;
    _showError = false;
    notifyListeners();
  }
}
