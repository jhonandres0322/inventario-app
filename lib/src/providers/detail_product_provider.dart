import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/services/products_service.dart';

class DetailProductProvider with ChangeNotifier {
  final ProductsService _productService = ProductsService();
  deleteProduct(ProductModel productToDelete) async {
    await _productService.deleteProduct(productToDelete);
  }
}
