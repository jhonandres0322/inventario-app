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
    text: '2009291609TS',
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
      messageError = 'Ingrese el código de barras';
      isError = true;
      notifyListeners();

      return;
    }

    isLoading = true;

    notifyListeners();

    final result = await _repository.findProductsByBarcode(
      barcodeController.text,
    );

    result.when(
      ok: (products) {
        if (products.isEmpty) {
          messageError = 'No se encontraron productos';
          isError = true;
        } else {
          _productsSelected = products;
          _sizes = products.map((product) => product.size).toList();
          messageSuccess = 'Producto encontrado';
          isSuccess = true;
        }
      },
      err: (e) {
        messageError =
            'No se pudo encontrar el producto, por favor intente más tarde';
        isError = true;
      },
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateProduct() async {
    isLoading = true;
    messageSuccess = null;
    messageError = null;
    notifyListeners();

    final productUpdate = productSelected?.copyWith(
      quantity: int.tryParse(quantityController.text),
    );

    final result = await _repository.updateProduct(productUpdate!);
    result.when(
      ok: (productUpdated) {
        _productSelected = productUpdated;
        messageSuccess = 'Producto actualizado correctamente';
        isSuccess = true;
        _getProductsProvider.load();
      },
      err: (e) {
        messageError = e;
        isError = true;
      },
    );

    isLoading = false;
    notifyListeners();
  }
}
