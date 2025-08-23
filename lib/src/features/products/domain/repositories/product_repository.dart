import 'package:inventario_app/src/core/paging.dart';
import 'package:inventario_app/src/core/result.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Result<List<Product>>> getAll();
  Future<Result<Product>> save(Product product);
  Future<Result<Page<Product>>> getPage(PageParams params);
}
