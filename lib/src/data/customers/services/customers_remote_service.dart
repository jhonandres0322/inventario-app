import 'package:inventario_app/src/data/services/supabase/supabase_service.dart';
import 'package:inventario_app/src/domain/customers/models/customer.dart';

final class CustomersRemoteService {
  final SupabaseService _supabaseService;

  const CustomersRemoteService(this._supabaseService);

  Future<Customer> saveCustomer(Customer customer) async {
    final customerSaved = await _supabaseService.client
        .from('clientes')
        .insert(customer.toJson())
        .select()
        .single();
    return Customer.fromJson(customerSaved);
  }
}
