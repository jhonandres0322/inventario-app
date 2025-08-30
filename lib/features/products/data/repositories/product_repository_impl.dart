import 'package:inventario_app/src/config/paging.dart';
import 'package:inventario_app/src/config/result.dart';
import 'package:inventario_app/features/products/data/datasources/product_remote_source.dart';
import 'package:inventario_app/features/products/data/models/product_model.dart';
import 'package:inventario_app/features/products/domain/entities/product.dart';
import 'package:inventario_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteSource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Future<Result<List<Product>>> getAll() async {
    try {
      final list = await datasource.getAll();
      return Ok(list.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<Product>> save(Product product) async {
    try {
      final model = ProductModel.fromEntity(product);
      final savedModel = await datasource.save(model);
      return Ok(savedModel.toEntity());
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<Result<Page<Product>>> getPage(PageParams params) async {
    try {
      final pageModel = await datasource.getPage(params);
      final entities = pageModel.items
          .map((m) => m.toEntity())
          .toList(growable: false);

      return Ok(
        Page<Product>(
          hasMore: pageModel.hasMore,
          items: entities,
          nextOffset: pageModel.nextOffset,
        ),
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}
