import 'dart:async';
import 'dart:developer';

import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/providers/list_customers_provider.dart';
import 'package:inventario_app/src/services/customers_service.dart';
import 'package:inventario_app/src/utils/models/params_model_util.dart';

class CustomersProvider extends ListCustomersProvider {
  int _currentPage = 0;
  bool _isLoading = false;
  final int _limit = 10;
  final String _orderProperty = 'fecha_registro';
  final CustomersService _customersService = CustomersService();
  String _search = '';
  Timer? _debounce;

  CustomersProvider() {
    log('[CustomersProvider.init] - Inicializando provider');
    loadCustomers();
  }

  int get currentPage => _currentPage;
  @override
  bool get isLoading => _isLoading;

  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  @override
  set isLoading(bool value) {
    _isLoading = value;
  }

  Future<void> _loadCustomers({required bool reset}) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    if (reset) {
      currentPage = 0;
      customers = [];
      isRefresh = false;
    } else {
      currentPage++;
    }

    final int from = _currentPage * _limit;
    final int to = from + _limit + 1;

    final params = ParamsModelUtil(
      from: from,
      to: to,
      orderProperty: _orderProperty,
      isOrderAscending: false,
    );

    final response = await _customersService.getCustomers(params);
    if (response.isEmpty && !reset) {
      _currentPage--;
    } else {
      customers = [...customers, ...response];
    }

    isLoading = false;
    notifyListeners();
  }

  void loadCustomers() {
    _loadCustomers(reset: true);
  }

  void loadCustomersNews() {
    _loadCustomers(reset: isRefresh);
  }

  @override
  List<CustomerModel> get filteredCustomers {
    if (_search.isEmpty) return customers;

    return customers.where((producto) {
      final nombre = producto.nombre.toLowerCase();
      return nombre.contains(_search.toLowerCase());
    }).toList();
  }

  void actualizarBusqueda(String valor) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search = valor;
      notifyListeners();
    });
  }

  void clearValueSearch() {
    _search = '';
    notifyListeners();
  }
}
