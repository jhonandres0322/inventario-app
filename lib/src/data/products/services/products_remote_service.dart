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
}
