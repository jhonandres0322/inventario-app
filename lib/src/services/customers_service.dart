import 'package:inventario_app/src/core/infrastructure/app_supabase.dart';
import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/utils/params_model_util.dart';

class CustomersService {
  final String tableNameCustomer = 'clientes';

  Future<List<CustomerModel>> getCustomers(ParamsModelUtil params) async {
    final List<CustomerModel> customers = await AppSupabase().getAll(
      tableNameCustomer,
      params,
      CustomerModel.fromMap,
    );
    return customers;
  }
}
