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

  Future<Result<Product>> saveProduct(Product productSave) async {
    try {
      final filters = [
        {'key': 'barcode', 'value': productSave.barcode},
        {'key': 'size', 'value': productSave.size},
      ];
      final productsFound = await productsRemoteService.findProductByFilters(
        filters,
      );

      if (productsFound.isEmpty) {
        final loadImagesService = loadImagesServiceFactory.getService(
          productSave.brand,
        );
        final images = await loadImagesService.load(productSave);
        productSave.images = images;
        final product = await productsRemoteService.saveProduct(productSave);
        return Ok(product);
      } else {
        final productFound = productsFound.first;
        final productUpdate = productFound.copyWith(
          quantity: productSave.quantity,
        );
        final productUpdated = await productsRemoteService.updateProduct(
          productUpdate,
        );

        return Ok(productUpdated);
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<Product>> getProductById(Product product) async {
    try {
      final productFound = await productsRemoteService.getProductById(product);

      return Ok(productFound);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<void>> deleteProduct(Product productDelete) async {
    try {
      await productsRemoteService.deleteProduct(productDelete);

      return Ok(null);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<List<Product>>> findProductsByBarcode(String barcode) async {
    try {
      final filters = [
        {'key': 'barcode', 'value': barcode},
      ];
      final products = await productsRemoteService.findProductByFilters(
        filters,
      );

      return Ok(products);
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<Product>> updateProduct(Product product) async {
    try {
      final productUpdated = await productsRemoteService.updateProduct(product);

      return Ok(productUpdated);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
