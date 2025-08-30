import 'package:inventario_app/src/config/result.dart';
import 'package:inventario_app/features/products/domain/entities/product.dart';
import 'package:inventario_app/features/products/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);
  Future<Result<List<Product>>> call() => repository.getAll();
}
