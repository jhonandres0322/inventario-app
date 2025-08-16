import 'package:inventario_app/src/core/result.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/repositories/product_repository.dart';

class SaveProduct {
  final ProductRepository repository;

  SaveProduct(this.repository);

  Future<Result<Product>> call(Product product) => repository.save(product);
}
