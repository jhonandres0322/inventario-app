import 'package:inventario_app/src/config/response/result.dart';
import 'package:inventario_app/src/config/pagination/paging.dart';
import 'package:inventario_app/src/data/products/services/images/load_images_service_factory.dart';
import 'package:inventario_app/src/data/products/services/products_remote_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

final class ProductsRepository {
  final ProductsRemoteService productsRemoteService;
  final LoadImagesServiceFactory loadImagesServiceFactory;

  ProductsRepository(this.productsRemoteService, this.loadImagesServiceFactory);

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
      final loadImagesService = loadImagesServiceFactory.getService(
        savedProduct.brand,
      );
      final images = await loadImagesService.load(savedProduct);
      savedProduct.images = images;
      final product = await productsRemoteService.saveProduct(savedProduct);

      return Ok(product);
    } catch (e) {
      return Error(e.toString());
    }
  }

  getProductById(Product product) async {
    try {
      final productFound = await productsRemoteService.getProductById(product);

      return Ok(productFound);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
