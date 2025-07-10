import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LoadProductProvider with ChangeNotifier {
  Barcode? _barcode;

  Barcode? get barcode => _barcode;
  String? get valueBarcode => _barcode?.displayValue;

  void setBarcode(Barcode barcode) {
    _barcode = barcode;
    notifyListeners();
  }

  void clearBarcode() {
    _barcode = null;
    notifyListeners();
  }
}
