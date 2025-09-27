import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/di/injection.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/core/viewmodels/generic_save_provider.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';

class UpdateProductProvider extends GenericSaveProvider<Product> {
  final GetProductsProvider _getProductsProvider;
  final ProductsRepository _repository = sl<ProductsRepository>();

  List<String> _sizes = [];
  String? _sizeSelected;
  List<Product> _productsSelected = [];
  Product? _productSelected;

  String? get sizeSelected => _sizeSelected;
  List<String> get sizes => _sizes;
  Product? get productSelected => _productSelected;

  final TextEditingController barcodeController = TextEditingController(
    text: '7704803436662',
  );
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  set sizeSelected(String? value) {
    _sizeSelected = value;
    _productSelected = _productsSelected
        .where((product) => product.size == value)
        .first;

    notifyListeners();
  }

  UpdateProductProvider(this._getProductsProvider);

  Future<void> searchProductByBarcode() async {
    if (barcodeController.text.isEmpty) {
      error = 'Ingrese el código de barras';
      showError = true;
      notifyListeners();

      return;
    }

    loading = true;

    notifyListeners();

    final result = await _repository.findProductsByBarcode(
      barcodeController.text,
    );

    result.when(
      ok: (products) {
        _productsSelected = products;
        _sizes = products.map((product) => product.size).toList();
        success = 'Producto encontrado';
        showSuccess = true;
      },
      err: (e) {
        error = e;
        showError = true;
      },
    );

    loading = false;
    notifyListeners();
  }

  Future<void> updateProduct() async {
    loading = true;
    error = null;
    success = null;
    notifyListeners();

    final productUpdate = productSelected?.copyWith(
      quantity: int.tryParse(quantityController.text),
    );

    final result = await _repository.updateProduct(productUpdate!);
    result.when(
      ok: (productUpdated) {
        _productSelected = productUpdated;
        success = 'Producto actualizado';
        showSuccess = true;
        _getProductsProvider.load();
      },
      err: (e) {
        error = e;
        showError = true;
      },
    );

    loading = false;
    notifyListeners();
  }
}
