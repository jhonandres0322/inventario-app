import 'package:inventario_app/src/features/products/data/datasources/product_datasource.dart';
import 'package:inventario_app/src/features/products/data/models/product_model.dart';

class ProductLocalDatasource implements ProductDatasource {
  final _db = <ProductModel>[];

  @override
  Future<List<ProductModel>> getAll() async {
    Future.delayed(Duration(seconds: 2));
    return List.unmodifiable(_db);
  }
}
