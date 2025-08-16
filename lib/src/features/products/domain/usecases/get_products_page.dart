import 'package:inventario_app/src/core/paging.dart';
import 'package:inventario_app/src/core/result.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/repositories/product_repository.dart';

class GetProductsPageUseCase {
  final ProductRepository repository;
  GetProductsPageUseCase(this.repository);

  Future<Result<Page<Product>>> call(PageParams params) =>
      repository.getPage(params);
}
