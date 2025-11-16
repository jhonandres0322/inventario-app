import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/di/injection.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/domain/products/valueobjects/brand.dart';
import 'package:inventario_app/src/domain/products/valueobjects/category.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/domain/products/valueobjects/genre.dart';
import 'package:inventario_app/src/ui/core/viewmodels/generic_save_provider.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';

enum StatesSaveProductScreen { creating, createdIncomplete }

class SaveProductProvider extends GenericSaveProvider<Product> {
  final GetProductsProvider _getProductsProvider;
  final ProductsRepository _repository = sl<ProductsRepository>();

  StatesSaveProductScreen _stateCurrent = StatesSaveProductScreen.creating;

  final List<String> _categories = CategoryProduct.all
      .map((c) => c.label)
      .toList();
  String? _categorySelected = 'Camisetas';
  final List<String> _sizes = [];
  String? _sizeSelected;
  String? _genreSelected;
  final List<String> brands = Brand.all.map((c) => c.label).toList();
  final List<String> genres = GenreProduct.all.map((c) => c.label).toList();
  String? _brandSelected;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController(
    text: '7704803271010',
  );
  final TextEditingController salesPriceController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  File? _selectedImage;

  List<String> get categories => _categories;
  String? get categorySelected => _categorySelected;
  List<String> get sizes => _sizes;
  String? get sizeSelected => _sizeSelected;
  String? get brandSelected => _brandSelected;
  String? get genreSelected => _genreSelected;
  StatesSaveProductScreen get stateCurrent => _stateCurrent;
  File? get selectedImage => _selectedImage;

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

  set genreSelected(String? value) {
    _genreSelected = value;

    notifyListeners();
  }

  set selectedImage(File? value) {
    _selectedImage = value;
    notifyListeners();
  }

  SaveProductProvider(this._getProductsProvider);

  List<String> getSizes() {
    return CategoryProduct.fromLabel(
      _categorySelected!,
    ).allowSizes.map((s) => s.label).toList();
  }

  Future<void> saveProduct() async {
    isLoading = true;
    messageError = null;
    savedEntity = null;
    notifyListeners();

    final product = Product(
      name: nameController.text.trim(),
      size: sizeSelected!.trim(),
      brand: brandSelected!.trim(),
      purchasePrice: int.parse(purchasePriceController.text),
      salesPrice: int.parse(salesPriceController.text),
      quantity: int.parse(quantityController.text),
      barcode: barcodeController.text.trim(),
      type: _categorySelected!.trim(),
      genre: _genreSelected!.trim(),
      images: null,
    );

    final result = await _repository.saveProduct(product);
    result.when(
      ok: (savedProduct) {
        savedEntity = savedProduct;
        if (savedEntity!.name.isNotEmpty) {
          messageSuccess = 'Producto creado con exito';
          isSuccess = true;
          _getProductsProvider.load();
        } else {
          _stateCurrent = StatesSaveProductScreen.createdIncomplete;
          messageError = 'Producto creado sin nombre e imagen';
          isError = true;
        }
      },
      err: (err) {
        messageError =
            'Error al crear el producto. Por favor intente más tarde';
        isError = true;
      },
    );

    clearForm();
    isLoading = false;
    notifyListeners();
  }

  updateProductIncomplete() async {
    isLoading = true;
    notifyListeners();

    final product = savedEntity?.copyWith(name: nameController.text);

    final result = await _repository.updateProductIncomplete(
      product!,
      _selectedImage!,
    );

    result.when(
      ok: (updatedProduct) {
        savedEntity = updatedProduct;
        isSuccess = true;
        messageSuccess = 'Producto completado con exito';
        _getProductsProvider.load();
      },
      err: (err) {
        messageError =
            'Error al completar la creacioón del producto. Por favor intente más tarde';
        isError;
      },
    );

    clearForm();
    isLoading = false;
    _stateCurrent = StatesSaveProductScreen.creating;
    notifyListeners();
  }

  void clearForm() {
    nameController.text = '';
    purchasePriceController.text = '';
    salesPriceController.text = '';
    quantityController.text = '';
    _categorySelected = 'Camisetas';
    _sizeSelected = '';
    _brandSelected = '';

    notifyListeners();
  }
}
