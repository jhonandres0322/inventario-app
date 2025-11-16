import 'package:flutter/material.dart';

class GenericSaveProvider<T> extends ChangeNotifier {
  bool _isLoading = false;
  String? _messageError;
  String? _messageSuccess;
  T? _savedEntity;
  bool _isSuccess = false;
  bool _isError = false;

  bool get isLoading => _isLoading;
  String? get messageError => _messageError;
  String? get messageSuccess => _messageSuccess;
  T? get savedEntity => _savedEntity;
  bool get isSuccess => _isSuccess;
  bool get isError => _isError;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set savedEntity(T? value) {
    _savedEntity = value;
    notifyListeners();
  }

  set messageError(String? value) {
    _messageError = value;
    notifyListeners();
  }

  set messageSuccess(String? value) {
    _messageSuccess = value;
    notifyListeners();
  }

  set isSuccess(bool value) {
    _isSuccess = value;
    notifyListeners();
  }

  set isError(bool value) {
    _isError = value;
    notifyListeners();
  }

  void resetState() {
    _messageError = null;
    _messageSuccess = null;
    _isError = false;
    _isSuccess = false;
    notifyListeners();
  }
}
