import 'package:inventario_app/src/config/response/result.dart';
import 'package:inventario_app/src/config/pagination/paging.dart';
import 'package:inventario_app/src/data/products/services/load_info_website/load_info_from_website_service_factory.dart';
import 'package:inventario_app/src/data/products/services/products_remote_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/domain/products/services/dtos/filter_products_dto.dart';

final class ProductsRepository {
  final ProductsRemoteService productsRemoteService;
  final LoadInfoFromWebsiteServiceFactory loadInfoFromWebsiteServiceFactory;

  ProductsRepository(
    this.productsRemoteService,
    this.loadInfoFromWebsiteServiceFactory,
  );

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
        final loadInfoFromWebSiteService = loadInfoFromWebsiteServiceFactory
            .getService(productSave.brand);
        final loadInfoFromWebSiteDto = await loadInfoFromWebSiteService.load(
          productSave,
        );
        productSave = productSave.copyWith(
          name: loadInfoFromWebSiteDto.name,
          images: loadInfoFromWebSiteDto.images,
        );
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

  Future<Result<List<Product>>> filterProducts(
    FilterProductsDto filters,
  ) async {
    try {
      final filterList = <Map<String, dynamic>>[];

      if (filters.brand != null) {
        filterList.add({'key': 'brand', 'value': filters.brand});
      }
      if (filters.type != null) {
        filterList.add({'key': 'type', 'value': filters.type});
      }
      if (filters.size != null) {
        filterList.add({'key': 'size', 'value': filters.size});
      }
      if (filters.genre != null) {
        filterList.add({'key': 'genre', 'value': filters.genre});
      }

      final products = await productsRemoteService.findProductByFilters(
        filterList,
      );
      return Ok(products);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
