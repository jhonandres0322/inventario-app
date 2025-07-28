import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/services/products_service.dart';
import 'package:inventario_app/src/utils/validators/validators_form_util.dart';

class DetailProductProvider with ChangeNotifier, ValidatorsFormUtil {
  final ProductsService _productService = ProductsService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get priceController => _priceController;
  TextEditingController get quantityController => _quantityController;

  void changeValuePriceForm(String value) {
    _priceController.text = value;
  }

  void changeValueQuantityForm(String value) {
    _quantityController.text = value;
  }

  deleteProduct(ProductModel productToDelete) async {
    await _productService.deleteProduct(productToDelete);
  }

  Future<bool> updateProduct(ProductModel productToUpdate) async {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      final productUpdate = productToUpdate.copyWith(
        cantidad: quantityController.text,
        precioCompra: priceController.text,
      );
      productUpdate.calculateCommision();
      productUpdate.calculateRealCost();
      await _productService.updateProduct(productUpdate);
      return true;
    }
    return false;
  }
}
