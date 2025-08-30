import 'package:inventario_app/src/config/paging.dart';
import 'package:inventario_app/src/config/result.dart';
import 'package:inventario_app/features/products/domain/entities/product.dart';
import 'package:inventario_app/features/products/domain/repositories/product_repository.dart';

class GetProductsPageUseCase {
  final ProductRepository repository;
  GetProductsPageUseCase(this.repository);

  Future<Result<Page<Product>>> call(PageParams params) =>
      repository.getPage(params);
}
