import 'dart:developer';

import 'package:inventario_app/src/core/infrastructure/app_kliiker.dart';
import 'package:inventario_app/src/core/infrastructure/app_supabase.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/utils/models/params_model_util.dart';

class ProductsService {
  final AppKliiker _appKliiker = AppKliiker();
  final String _tableNameProduct = 'productos';

  Future<bool> saveProduct(ProductModel product) async {
    List<String> imagenes = await _appKliiker.getImagesFromWebsite(
      product.codigoKliker,
    );

    product.foto1 = imagenes.first;
    product.foto2 = imagenes.last;
    product.calculateCommision();
    product.calculateRealCost();

    final isResponseNotEmpty = await AppSupabase().insert(
      _tableNameProduct,
      product.toMap(),
    );

    return isResponseNotEmpty;
  }

  Future<List<ProductModel>> getProducts(ParamsModelUtil params) async {
    final List<ProductModel> products = await AppSupabase()
        .getAll<ProductModel>(_tableNameProduct, params, ProductModel.fromMap);
    return products;
  }

  Future<void> updateProduct(ProductModel productToModel) async {
    await AppSupabase().updateOne(
      _tableNameProduct,
      productToModel.id,
      productToModel.toMap,
    );
  }

  Future<void> deleteProduct(ProductModel productToDelete) async {
    await AppSupabase().deleteOne(_tableNameProduct, productToDelete.id);
  }
}
