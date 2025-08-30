import 'package:inventario_app/src/config/paging.dart';
import 'package:inventario_app/src/config/result.dart';
import 'package:inventario_app/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Result<List<Product>>> getAll();
  Future<Result<Product>> save(Product product);
  Future<Result<Page<Product>>> getPage(PageParams params);
}
