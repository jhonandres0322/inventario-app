import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/di/injection.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/domain/products/services/dtos/filter_products_dto.dart';
import 'package:inventario_app/src/domain/products/valueobjects/brand.dart';
import 'package:inventario_app/src/domain/products/valueobjects/category.dart';
import 'package:inventario_app/src/domain/products/valueobjects/genre.dart';

class CatalogProductsProvider extends ChangeNotifier {
  final ProductsRepository _repository = sl<ProductsRepository>();
  final List<Product> _products = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _brands = Brand.all.map((brand) => brand.label).toList();
  final List<String> _categories = CategoryProduct.all
      .map((category) => category.label)
      .toList();
  final List<String> _sizes = [];
  final List<String> _genres = GenreProduct.all
      .map((genre) => genre.label)
      .toList();

  String? _brandSelected;
  String? _categorySelected;
  String? _sizeSelected;
  String? _genreSelected;

  bool _loading = false;
  String? _messageError;
  String? _messageSuccess;
  bool _showSuccess = false;
  bool _showError = false;

  List<Product> get products => _products;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  List<String> get brands => _brands;
  List<String> get categories => _categories;
  List<String> get sizes => _sizes;
  List<String> get genres => _genres;
  String? get brandSelected => _brandSelected;
  String? get categorySelected => _categorySelected;
  String? get sizeSelected => _sizeSelected;
  String? get genreSelected => _genreSelected;
  bool get isLoading => _loading;
  String? get messageError => _messageError;
  String? get messageSuccess => _messageSuccess;
  bool get showSuccess => _showSuccess;
  bool get showError => _showError;

  set brandSelected(String? value) {
    _brandSelected = value;
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

  set genreSelected(String? value) {
    _genreSelected = value;
    notifyListeners();
  }

  void clearForm() {
    _brandSelected = null;
    _categorySelected = null;
    _genreSelected = null;
    _sizeSelected = null;
  }

  List<String> getSizes() {
    if (categorySelected == null || categorySelected!.isEmpty) {
      return [];
    }
    return CategoryProduct.fromLabel(
      categorySelected!,
    ).allowSizes.map((s) => s.label).toList();
  }

  void resetState() {
    _showError = false;
    _showSuccess = false;
    notifyListeners();
  }

  void filterProducts() async {
    _products.clear();
    _loading = true;

    notifyListeners();

    final filters = FilterProductsDto(
      brand: _brandSelected,
      genre: _genreSelected,
      size: _sizeSelected,
      type: _categorySelected,
    );

    final result = await _repository.filterProducts(filters);

    result.when(
      ok: (list) {
        if (list.isEmpty) {
          _messageError = 'No se encontraron productos';
          _showError = true;
        } else {
          _products.addAll(list);
          _messageSuccess = 'Productos encontrados';
          _showSuccess = true;
        }
      },
      err: (err) {
        _messageError = err;
        _showError = true;
      },
    );
    _scaffoldKey.currentState!.closeDrawer();
    clearForm();
    _loading = false;
    notifyListeners();
  }
}
