import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/services/customers_service.dart';
import 'package:inventario_app/src/utils/validators/validators_form_util.dart';

class CreateCustomerProvider with ChangeNotifier, ValidatorsFormUtil {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CustomersService _customersService = CustomersService();

  GlobalKey<FormState> get formKey => _formKey;
  String? _name;
  String? _phone;
  String? _address;
  bool? _isLoading = false;

  String? get name => _name;
  String? get phone => _phone;
  String? get address => _address;
  bool? get isLoading => _isLoading;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }

  set address(String? value) {
    _address = value;
    notifyListeners();
  }

  set isLoading(bool? value) {
    _isLoading = value;
    notifyListeners();
  }

  String? validateName(String? value) {
    if (value!.isEmpty) return 'El nombre es obligatorio';
    if (value.length < 2) return 'El nombre es invalido';
    return null;
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) return 'El telefono es obligatorio';
    if (value.length != 10) return 'El telefono debe tener 10 digitos';
    return null;
  }

  bool disabledButtonSaveForm() {
    bool value =
        !((_name?.isNotEmpty ?? false) && (_phone?.isNotEmpty ?? false));
    return value;
  }

  void clearAll() {
    _name = null;
    _address = null;
    _phone = null;
    notifyListeners();
  }

  Future<bool> onSubmitForm() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      isLoading = true;
      final customer = CustomerModel.fromMap({
        "nombre": _name,
        "telefono": _phone,
        "direccion": _address,
      });
      bool response = await _customersService.saveCustomer(customer);
      isLoading = false;
      return response;
    }
    return false;
  }
}
