import 'package:inventario_app/src/config/response/result.dart';
import 'package:inventario_app/src/data/customers/services/customers_remote_service.dart';
import 'package:inventario_app/src/domain/customers/models/customer.dart';

final class CustomersRepository {
  final CustomersRemoteService customersRemoteService;

  CustomersRepository(this.customersRemoteService);

  Future<Result<Customer>> saveCustomer(Customer savedCustomer) async {
    try {
      final customer = await customersRemoteService.saveCustomer(savedCustomer);

      return Ok(customer);
    } catch (e) {
      return Error(e.toString());
    }
  }
}
