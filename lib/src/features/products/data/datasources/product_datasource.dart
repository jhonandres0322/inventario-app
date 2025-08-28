import 'package:inventario_app/src/features/products/data/models/product_model.dart';

abstract class ProductDatasource {
  Future<List<ProductModel>> getAll();
  Future<ProductModel> save(ProductModel productModel);
}
