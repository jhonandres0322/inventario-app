import 'package:inventario_app/src/config/response/result.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

class SaveProductUseCase {
  final ProductsRepository productsRepository;

  SaveProductUseCase(this.productsRepository);

  Future<Result<Product>> call(Product product) =>
      productsRepository.saveProduct(product);
}
