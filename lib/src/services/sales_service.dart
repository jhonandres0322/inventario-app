import 'package:inventario_app/src/core/infrastructure/app_supabase.dart';
import 'package:inventario_app/src/models/sale_model.dart';

class SalesService {
  final String _tableNameSale = 'ventas';

  Future<bool> saveSale(SaleModel sale) async {
    final isResponseNotEmpty = await AppSupabase().insert(
      _tableNameSale,
      sale.toMap(),
    );

    return isResponseNotEmpty;
  }
}
