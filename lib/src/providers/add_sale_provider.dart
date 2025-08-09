import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/services/customers_service.dart';
import 'package:inventario_app/src/services/products_service.dart';
import 'package:inventario_app/src/utils/mocks/mock_supabase_util.dart';
import 'package:inventario_app/src/utils/models/params_model_util.dart';

class AddSaleProvider with ChangeNotifier {
  bool isTest = true;
  String _customerSelected = '';
  final String _orderProperty = 'nombre';
  final CustomersService _customersService = CustomersService();
  final ProductsService _productsService = ProductsService();
  final MockSupabaseUtil _mockSupabaseUtil = MockSupabaseUtil();
  List<CustomerModel> _customers = [];
  List<ProductModel> _products = [];
  bool _isLoading = false;
  final List<String> paymentTypes = ["Contado", "Credito"];

  String get customerSelected => _customerSelected;
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

    _customers = [...customers, ...response];
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

    _products = [...products, ...response];
  }
}
