import 'package:inventario_app/src/config/di/injection.dart';
import 'package:inventario_app/src/data/customers/repositories/customers_repository.dart';
import 'package:inventario_app/src/domain/customers/models/customer.dart';
import 'package:inventario_app/src/ui/core/viewmodels/generic_save_provider.dart';

class SaveCustomerProvider extends GenericSaveProvider {
  final CustomersRepository _repository = sl<CustomersRepository>();

  Future<void> saveCustomer({
    required String name,
    required String phone,
    required String address,
  }) async {
    loading = true;
    error = null;
    saved = null;
    notifyListeners();

    final customer = Customer(name: name, phone: phone, address: address);

    final result = await _repository.saveCustomer(customer);

    result.when(
      ok: (savedCustomer) {
        saved = savedCustomer;
        showSuccess = true;
      },
      err: (error) {
        error = error;
        showError = true;
      },
    );

    loading = false;
    notifyListeners();
  }
}
