import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_sizes_clothes.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class LoadProductProvider with ChangeNotifier {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Barcode? _barcode;
  String? _nameReferenceProduct;
  String? _priceProduct;
  String? _quantity;
  String? _sizeSelected;
  String? _typeClothes = 'camisas';
  final TextEditingController barcodeController = TextEditingController();

  Barcode? get barcode => _barcode;
  String? get nameReferenceProduct => _nameReferenceProduct;
  String? get priceProduct => _priceProduct;
  String? get quantity => _quantity;
  String? get sizeSelected => _sizeSelected;
  String? get typeClothes => _typeClothes;
  GlobalKey<FormState> get formKey => _formKey;

  void setBarcode(Barcode barcode) {
    _barcode = barcode;
    barcodeController.text = barcode.displayValue ?? '';
    notifyListeners();
  }

  void setNameReferenceProduct(String value) {
    _nameReferenceProduct = value;
    notifyListeners();
  }

  void setPriceProduct(String value) {
    _priceProduct = value;
    notifyListeners();
  }

  void setQuantity(String value) {
    _quantity = value;
    notifyListeners();
  }

  void setSizeSelected(String? value) {
    _sizeSelected = value;
    notifyListeners();
  }

  void setTypeClothes(String value) {
    _typeClothes = value;
    notifyListeners();
  }

  List<String> getSizes() {
    return typeClothes == 'camisas'
        ? AppSizesClothes().sizesText
        : AppSizesClothes().sizesNumber;
  }

  String? validateReferenceForm(String? value) {
    if (value!.isEmpty) return 'La referencia es obligatoria';
    if (value.length < 3) return 'Valor invalido';

    return null;
  }

  String? validateNumberForm(String? value) {
    if (value!.isEmpty) return 'El precio es obligatorio';
    if (int.parse(value) <= 0) return 'El precio debe ser mayor a 0';

    return null;
  }

  void clearBarcode() {
    _barcode = null;
    notifyListeners();
  }

  void clearSizeSelected() {
    _sizeSelected = null;
    notifyListeners();
  }

  bool disabledButtonSaveForm() {
    final value =
        !((_nameReferenceProduct?.isNotEmpty ?? false) &&
            (_priceProduct?.isNotEmpty ?? false) &&
            (_sizeSelected?.isNotEmpty ?? false) &&
            (_barcode?.displayValue?.isNotEmpty ?? false) &&
            (_quantity?.isNotEmpty ?? false));
    return value;
  }

  void onSubmitForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      log('===== Información guardada correctamente');
      log('===== Referencia $_nameReferenceProduct');
      log('===== Precio $_priceProduct');
      log('===== Talla $_sizeSelected');
      log('===== Codigo de Barras ${_barcode?.displayValue}');
      log('===== Cantidad $_quantity');
    }
  }
}
