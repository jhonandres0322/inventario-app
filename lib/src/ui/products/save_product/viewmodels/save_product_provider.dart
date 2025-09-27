import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/di/injection.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/domain/products/valueobjects/brand.dart';
import 'package:inventario_app/src/domain/products/valueobjects/category.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/core/viewmodels/generic_save_provider.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';

class SaveProductProvider extends GenericSaveProvider<Product> {
  final GetProductsProvider _getProductsProvider;
  final ProductsRepository _repository = sl<ProductsRepository>();

  final List<String> _categories = CategoryProduct.all
      .map((c) => c.label)
      .toList();
  String? _categorySelected = 'Camisetas';
  final List<String> _sizes = [];
  String? _sizeSelected;
  final List<String> brands = Brand.all.map((c) => c.label).toList();
  String? _brandSelected;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController(
    text: '7704803436662',
  );
  final TextEditingController earningsPercentageController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  List<String> get categories => _categories;
  String? get categorySelected => _categorySelected;
  List<String> get sizes => _sizes;
  String? get sizeSelected => _sizeSelected;
  String? get brandSelected => _brandSelected;

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

  Future<void> saveProduct() async {
    loading = true;
    error = null;
    saved = null;
    notifyListeners();

    final product = Product(
      name: nameController.text.trim(),
      size: sizeSelected!.trim(),
      brand: brandSelected!.trim(),
      purchasePrice: int.parse(purchasePriceController.text),
      quantity: int.parse(quantityController.text),
      barcode: barcodeController.text.trim(),
      type: _categorySelected!.trim(),
      earningsPercentage: int.parse(earningsPercentageController.text),
      images: null,
    );

    final result = await _repository.saveProduct(product);
    result.when(
      ok: (savedProduct) {
        saved = savedProduct;
        showSuccess = true;
        _getProductsProvider.load();
      },
      err: (error) {
        error = error;
        showError = true;
      },
    );

    clearForm();
    loading = false;
    notifyListeners();
  }

  void clearForm() {
    nameController.text = '';
    purchasePriceController.text = '';
    barcodeController.text = '';
    earningsPercentageController.text = '';
    quantityController.text = '';
    _categorySelected = 'Camisetas';
    _sizeSelected = '';
    _brandSelected = '';

    notifyListeners();
  }
}
