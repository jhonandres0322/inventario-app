import 'package:inventario_app/src_old/models/customer_model.dart';
import 'package:inventario_app/src_old/utils/providers/list_provider_util.dart';

class ListCustomersProvider extends ListProviderUtil {
  List<CustomerModel> customers = [];

  List<CustomerModel> get filteredCustomers => [];
}
