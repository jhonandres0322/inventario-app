import 'package:inventario_app/src/core/result.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);
  Future<Result<List<Product>>> call() => repository.getAll();
}
