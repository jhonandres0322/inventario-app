import 'package:inventario_app/src/config/pagination/paging.dart';
import 'package:inventario_app/features/products/data/datasources/product_datasource.dart';
import 'package:inventario_app/features/products/data/models/product_model.dart';

abstract interface class ProductRemoteSource extends ProductDatasource {
  Future<Page<ProductModel>> getPage(PageParams params);
}
