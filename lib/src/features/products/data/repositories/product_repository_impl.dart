import 'package:inventario_app/src/core/paging.dart';
import 'package:inventario_app/src/core/result.dart';
import 'package:inventario_app/src/features/products/data/datasources/product_remote_source.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/repositories/product_repository.dart';

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
  Future<Result<Product>> save(Product product) {
    // TODO: implement save
    throw UnimplementedError();
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
