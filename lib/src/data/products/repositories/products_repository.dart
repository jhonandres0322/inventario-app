import 'package:inventario_app/src/config/response/result.dart';
import 'package:inventario_app/src/data/products/services/products_remote_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/config/pagination/paging.dart';

final class ProductsRepository {
  final ProductsRemoteService productsRemoteService;

  ProductsRepository(this.productsRemoteService);

  Future<Result<List<Product>>> getProducts() async {
    try {
      final remoteProducts = await productsRemoteService.getAll();
      return Ok(remoteProducts);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<Page<Product>>> getPage(PageParams params) async {
    try {
      final pageModel = await productsRemoteService.getPage(params);

      return Ok(pageModel);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<Product>> saveProduct(Product savedProduct) async {
    try {
      final product = await productsRemoteService.saveProduct(savedProduct);

      return Ok(product);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
