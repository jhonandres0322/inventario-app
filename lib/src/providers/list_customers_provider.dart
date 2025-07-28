import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/utils/providers/list_provider_util.dart';

class ListCustomersProvider extends ListProviderUtil {
  List<CustomerModel> customers = [];

  List<CustomerModel> get filteredCustomers => [];
}
