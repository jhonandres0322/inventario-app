import 'package:flutter/material.dart';
import 'package:inventario_app/src/di/injection.dart';
import 'package:inventario_app/features/products/domain/entities/product.dart';
import 'package:inventario_app/features/products/domain/usecases/save_product.dart';
import 'package:inventario_app/features/products/domain/vo/apparel_size/apparel_size.dart';
import 'package:inventario_app/features/products/domain/vo/apparel_size/apparel_size_catalog.dart';
import 'package:inventario_app/features/products/domain/vo/brand/brand.dart';
import 'package:inventario_app/features/products/domain/vo/product_category/product_category.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';

class SaveProductProvider extends ChangeNotifier {
  final SaveProductUseCase _save = sl<SaveProductUseCase>();
  final GetProductsProvider _getProductsProvider;

  bool _loading = false;
  String? _error;
  Product? _savedProduct;
  ProductCategory? _selectedCategory;
  Brand? _selectedBrand;
  ApparelSize? _selectedSize;

  bool get loading => _loading;
  String? get error => _error;
  Product? get savedProduct => _savedProduct;
  ProductCategory? get selectedCategory => _selectedCategory;
  Brand? get selectedBrand => _selectedBrand;
  ApparelSize? get selectedSize => _selectedSize;

  SaveProductProvider(this._getProductsProvider);

  List<ProductCategory> getCategories() => ProductCategory.values;
  List<Brand> getBrands() => Brand.values;
  List<ApparelSize> getSizes() {
    if (_selectedCategory == null) return [];
    return ApparelSizeCatalog.getSizesByCategory(_selectedCategory!);
  }

  void setSelectedCategory(ProductCategory? value) {
    _selectedCategory = value;
    _selectedSize = null;
    notifyListeners();
  }

  void setSelectedBrand(Brand? value) {
    _selectedBrand = value;
    notifyListeners();
  }

  void setSelectedSize(ApparelSize? value) {
    _selectedSize = value;
    notifyListeners();
  }

  Future<void> saveProduct(Product product) async {
    _loading = true;
    _error = null;
    notifyListeners();

    final result = await _save(product);
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
    notifyListeners();
  }

  void reset() {
    _selectedCategory = null;
    notifyListeners();
  }
}
