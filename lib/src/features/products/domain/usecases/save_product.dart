import 'package:inventario_app/src/core/result.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/repositories/product_repository.dart';

class SaveProductUseCase {
  final ProductRepository repository;

  SaveProductUseCase(this.repository);

  Future<Result<Product>> call(Product product) => repository.save(product);
}
