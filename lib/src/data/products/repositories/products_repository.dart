import 'package:inventario_app/src/config/response/result.dart';
import 'package:inventario_app/src/config/pagination/paging.dart';
import 'package:inventario_app/src/data/products/services/get_info_website/get_info_from_website_service_factory.dart';
import 'package:inventario_app/src/data/products/services/products_remote_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/domain/products/services/dtos/filter_products_dto.dart';

final class ProductsRepository {
  final ProductsRemoteService productsRemoteService;
  final GetInfoFromWebsiteServiceFactory getInfoFromWebsiteServiceFactory;

  ProductsRepository(
    this.productsRemoteService,
    this.getInfoFromWebsiteServiceFactory,
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
      ];
      final productsFound = await productsRemoteService.findProductByFilters(
        filters,
      );
      if (productsFound.isNotEmpty) {
        final productFoundBySize = productsFound.firstWhere(
          (product) => product.size == productSave.size,
          orElse: () => Product.empty(),
        );

        if (productFoundBySize.size.isNotEmpty) {
          final productUpdate = productFoundBySize.copyWith(
            quantity: productSave.quantity,
          );
          final productUpdated = await productsRemoteService.updateProduct(
            productUpdate,
          );

          return Ok(productUpdated);
        } else {
          productSave = productSave.copyWith(
            name: productsFound.first.name,
            images: productsFound.first.images,
          );

          final productSaved = await productsRemoteService.saveProduct(
            productSave,
          );

          return Ok(productSaved);
        }
      } else {
        final getInfoFromWebsiteService = getInfoFromWebsiteServiceFactory
            .getService(productSave.brand);
        final getInfoFromWebsiteDto = await getInfoFromWebsiteService.getInfo(
          productSave,
        );

        final url = await productsRemoteService.uploadFileFromUrl(
          getInfoFromWebsiteDto.images,
          productSave.brand,
          productSave.barcode,
        );

        productSave = productSave.copyWith(
          name: getInfoFromWebsiteDto.name,
          images: url,
        );

        final product = await productsRemoteService.saveProduct(productSave);

        return Ok(product);
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
