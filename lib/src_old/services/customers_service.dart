import 'package:inventario_app/src_old/core/infrastructure/app_supabase.dart';
import 'package:inventario_app/src_old/models/customer_model.dart';
import 'package:inventario_app/src_old/utils/models/params_model_util.dart';

class CustomersService {
  final String _tableNameCustomer = 'clientes';

  Future<List<CustomerModel>> getCustomers(ParamsModelUtil params) async {
    final List<CustomerModel> customers = await AppSupabase().getAll(
      _tableNameCustomer,
      params,
      CustomerModel.fromMap,
    );
    return customers;
  }

  Future<bool> saveCustomer(CustomerModel customer) async {
    final isResponseNotEmpty = await AppSupabase().insert(
      _tableNameCustomer,
      customer.toMap(),
    );

    return isResponseNotEmpty;
  }
}
