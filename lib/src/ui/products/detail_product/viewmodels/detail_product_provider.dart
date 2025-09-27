import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/di/injection.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';

class DetailProductProvider with ChangeNotifier {
  final GetProductsProvider _getProductsProvider;
  final _repository = sl<ProductsRepository>();

  bool _loading = false;
  String? _error;
  String? _success;
  Product? _deletedProduct;
  bool _showSuccess = false;
  bool _showError = false;

  bool get loading => _loading;
  String? get error => _error;
  String? get success => _success;
  Product? get deletedProduct => _deletedProduct;
  bool get showSuccess => _showSuccess;
  bool get showError => _showError;

  DetailProductProvider(this._getProductsProvider);

  Future<void> deleteProduct(Product product) async {
    _loading = true;
    _error = null;
    _deletedProduct = null;
    notifyListeners();

    final result = await _repository.deleteProduct(product);

    result.when(
      ok: (deletedProduct) {
        _deletedProduct = product;
        _success = 'Producto eliminado con exito';
        _showSuccess = true;
        _getProductsProvider.load();
      },
      err: (error) {
        _error = error;
        _showError = true;
      },
    );
    _loading = false;

    notifyListeners();
  }

  void resetState() {
    _deletedProduct = null;
    _error = null;
    _showSuccess = false;
    _showError = false;
    notifyListeners();
  }
}
