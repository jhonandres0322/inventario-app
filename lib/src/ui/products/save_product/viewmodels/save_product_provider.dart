import 'package:flutter/material.dart';

import 'package:inventario_app/src/config/di/injection.dart';
import 'package:inventario_app/src/domain/products/usecases/save_product_use_case.dart';
import 'package:inventario_app/src/domain/products/valueobjects/brand.dart';
import 'package:inventario_app/src/domain/products/valueobjects/category.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';

class SaveProductProvider extends ChangeNotifier {
  final GetProductsProvider _getProductsProvider;
  final SaveProductUseCase _save = sl<SaveProductUseCase>();

  bool _loading = false;
  String? _error;
  Product? _savedProduct;
  final List<String> _categories = CategoryProduct.all
      .map((c) => c.label)
      .toList();
  String? _categorySelected = 'Camisetas';
  final List<String> _sizes = [];
  String? _sizeSelected;
  final List<String> brands = Brand.all.map((c) => c.label).toList();
  String? _brandSelected;

  bool get loading => _loading;
  String? get error => _error;
  Product? get savedProduct => _savedProduct;
  List<String> get categories => _categories;
  String? get categorySelected => _categorySelected;
  List<String> get sizes => _sizes;
  String? get sizeSelected => _sizeSelected;
  String? get brandSelected => _brandSelected;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  set error(String? value) {
    _error = value;
    notifyListeners();
  }

  set categorySelected(String? value) {
    _categorySelected = value;
    _sizeSelected = null;
    notifyListeners();
  }

  set sizeSelected(String? value) {
    _sizeSelected = value;
    notifyListeners();
  }

  set brandSelected(String? value) {
    _brandSelected = value;
    notifyListeners();
  }

  SaveProductProvider(this._getProductsProvider);

  List<String> getSizes() {
    return CategoryProduct.fromLabel(
      _categorySelected!,
    ).allowSizes.map((s) => s.label).toList();
  }

  Future<void> saveProduct({
    required String name,
    required String purchasePrice,
    required String barcode,
    required String quantity,
    required String category,
    required String size,
    required String brand,
  }) async {
    _loading = true;
    _error = null;
    _savedProduct = null;
    notifyListeners();

    final product = Product(
      name: name,
      size: size,
      brand: brand,
      purchasePrice: int.parse(purchasePrice),
      quantity: int.parse(quantity),
      barcode: barcode,
      images: 'valor',
    );

    final result = await _save.call(product);
    result.when(
      ok: (savedProduct) {
        _savedProduct = savedProduct;
        _getProductsProvider.load();
      },
      err: (error) {
        _error = error;
      },
    );
    _loading = false;
    _savedProduct = null;
    notifyListeners();
  }
}
