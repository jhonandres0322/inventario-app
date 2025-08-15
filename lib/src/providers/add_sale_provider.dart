import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/models/sale_model.dart';
import 'package:inventario_app/src/services/customers_service.dart';
import 'package:inventario_app/src/services/products_service.dart';
import 'package:inventario_app/src/services/sales_service.dart';
import 'package:inventario_app/src/utils/mocks/mock_supabase_util.dart';
import 'package:inventario_app/src/utils/models/params_model_util.dart';
import 'package:inventario_app/src/utils/validators/validators_form_util.dart';

class AddSaleProvider with ChangeNotifier, ValidatorsFormUtil {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isTest = true;
  String _customerSelected = '';
  String _productSelected = '';
  String _quantity = '0';
  String _priceUnit = '0';
  final TextEditingController priceTotalController = TextEditingController();
  String _paymentTypeSelected = '';
  final SalesService _salesService = SalesService();

  final String _orderProperty = 'nombre';
  final CustomersService _customersService = CustomersService();
  final ProductsService _productsService = ProductsService();
  final MockSupabaseUtil _mockSupabaseUtil = MockSupabaseUtil();
  List<CustomerModel> _customers = [];
  List<ProductModel> _products = [];
  bool _isLoading = false;
  final List<String> paymentTypes = SalePaymentMethod.values
      .map((paymentMethod) => paymentMethod.value)
      .toList();

  GlobalKey<FormState> get formKey => _formKey;
  String get customerSelected => _customerSelected;
  String get productSelected => _productSelected;
  String get quantity => _quantity;
  String get priceUnit => _priceUnit;
  String get paymentTypeSelected => _paymentTypeSelected;

  bool get isLoading => _isLoading;
  List<CustomerModel> get customers => _customers;
  List<ProductModel> get products => _products;

  AddSaleProvider() {
    log('[AddSaleProvier.init] - Inicializando provider');
    loadAll();
  }

  set customerSelected(String value) {
    _customerSelected = value;
    notifyListeners();
  }

  set productSelected(String value) {
    _productSelected = value;
    notifyListeners();
  }

  set quantity(String value) {
    _quantity = value;
    calculatePriceTotal(quantity: value, priceUnit: _priceUnit);
    notifyListeners();
  }

  set priceUnit(String value) {
    _priceUnit = value;
    calculatePriceTotal(quantity: _quantity, priceUnit: value);
    notifyListeners();
  }

  void calculatePriceTotal({
    required String quantity,
    required String priceUnit,
  }) {
    final q = int.tryParse(quantity) ?? 0;
    final p = int.tryParse(priceUnit) ?? 0;
    final priceTotal = q * p;
    priceTotalController.text = priceTotal.toString();
  }

  set paymentTypeSelected(String value) {
    _paymentTypeSelected = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearForm() {
    _customerSelected = '';
    notifyListeners();
  }

  Future<void> loadAll() async {
    isLoading = true;
    notifyListeners();
    await _loadCustomers();
    await _loadProducts();
    isLoading = false;
    notifyListeners();
  }

  Future<void> _loadCustomers() async {
    final params = ParamsModelUtil(
      orderProperty: _orderProperty,
      isOrderAscending: true,
      isFetchAll: true,
    );
    final response = isTest
        ? await _mockSupabaseUtil.generateMockCustomers()
        : await _customersService.getCustomers(params);

    _customers = response;
  }

  Future<void> _loadProducts() async {
    final params = ParamsModelUtil(
      orderProperty: _orderProperty,
      isOrderAscending: true,
      isFetchAll: true,
    );
    final response = isTest
        ? await _mockSupabaseUtil.generateMockProducts()
        : await _productsService.getProducts(params);

    _products = response;
  }

  bool disabledButtonSaveForm() {
    final value =
        !((_productSelected.isNotEmpty) &&
            (_customerSelected.isNotEmpty) &&
            (quantity.isNotEmpty) &&
            (_priceUnit.isNotEmpty) &&
            (priceTotalController.text.isNotEmpty) &&
            (paymentTypeSelected.isNotEmpty));

    return value;
  }

  Future<bool> onSubmitForm() async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      _isLoading = true;
      final sale = SaleModel.fromMap({
        "id_cliente": _customerSelected,
        "id_producto": _productSelected,
        "cantidad": _quantity,
        "precio_unitario": _priceUnit,
        "total": priceTotalController.text,
        "estado": SaleState.pending.value,
        "forma_pago": _paymentTypeSelected,
        "esta_pagado": false,
      });
      log('sale  ${sale.toMap()}');
      final isSuccess = await _salesService.saveSale(sale);
      _isLoading = false;

      return isSuccess;
    }
    return false;
  }
}
