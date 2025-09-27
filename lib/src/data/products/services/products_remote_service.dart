import 'package:inventario_app/src/config/pagination/paging.dart';
import 'package:inventario_app/src/data/services/supabase_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

final class ProductsRemoteService {
  final SupabaseService _supabaseService;

  const ProductsRemoteService(this._supabaseService);

  Future<List<Product>> getAll() async {
    final rows = await _supabaseService.selectAll('productos');
    return rows.map(Product.fromJson).toList();
  }

  Future<Page<Product>> getPage(PageParams params) async {
    final from = params.offset;
    final toInclusive = params.offset + params.limit;

    final rows = await _supabaseService.client
        .from('productos')
        .select()
        .order('createdAt', ascending: false)
        .range(from, toInclusive);
    final list = List<Map<String, dynamic>>.from(rows);
    final hasMore = list.length > params.limit;
    final sliced = hasMore ? list.sublist(0, params.limit) : list;
    final models = sliced.map(Product.fromJson).toList(growable: false);

    return Page<Product>(
      items: models,
      hasMore: hasMore,
      nextOffset: params.offset + models.length,
    );
  }

  Future<Product> saveProduct(Product product) async {
    final productSaved = await _supabaseService.client
        .from("productos")
        .insert(product.toJson())
        .select()
        .single();
    return Product.fromJson(productSaved);
  }

  Future<Product> getProductById(Product product) async {
    final productFound = await _supabaseService.client
        .from("productos")
        .select()
        .eq('id', product.id!)
        .single();

    return Product.fromJson(productFound);
  }

  Future<void> deleteProduct(Product productDelete) async {
    await _supabaseService.client
        .from('productos')
        .delete()
        .eq('id', productDelete.id!);
  }

  Future<List<Product>> findProductByFilters(
    List<Map<String, dynamic>> filters,
  ) async {
    var query = _supabaseService.client.from('productos').select();

    for (var filter in filters) {
      query = query.eq(filter['key'], filter['value']);
    }

    final rows = await query;
    final list = List<Map<String, dynamic>>.from(rows);
    final productsFound = list.map(Product.fromJson).toList(growable: false);

    return productsFound;
  }

  Future<Product> updateProduct(Product product) async {
    final productJson = product.toJson();

    final productUpdated = await _supabaseService.client
        .from('productos')
        .update(productJson)
        .eq('id', product.id!)
        .select()
        .single();

    return Product.fromJson(productUpdated);
  }
}
