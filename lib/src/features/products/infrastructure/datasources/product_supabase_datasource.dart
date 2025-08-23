import 'package:inventario_app/src/core/paging.dart';
import 'package:inventario_app/src/features/products/data/datasources/product_remote_source.dart';
import 'package:inventario_app/src/features/products/data/models/product_model.dart';
import 'package:inventario_app/src/shared/infrastructure/ports/supabase_port.dart';

final class ProductSupabaseDatasource implements ProductRemoteSource {
  final SupabaseClientPort supa;
  const ProductSupabaseDatasource(this.supa);

  @override
  Future<List<ProductModel>> getAll() async {
    final rows = await supa.selectAll('productos');
    return rows.map(ProductModel.fromMap).toList(growable: false);
  }

  @override
  Future<Page<ProductModel>> getPage(PageParams params) async {
    final from = params.offset;
    final toInclusive = params.offset + params.limit;

    final rows = await supa.client
        .from('productos')
        .select()
        .order('fecha_creacion', ascending: false)
        .range(from, toInclusive);

    final list = List<Map<String, dynamic>>.from(rows);
    final hasMore = list.length > params.limit;
    final sliced = hasMore ? list.sublist(0, params.limit) : list;

    final models = sliced.map(ProductModel.fromMap).toList(growable: false);

    return Page<ProductModel>(
      items: models,
      hasMore: hasMore,
      nextOffset: params.offset + models.length,
    );
  }
}
