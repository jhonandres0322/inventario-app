import 'dart:developer';
import 'dart:async';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/providers/list_product_provider.dart';
import 'package:inventario_app/src/services/products_service.dart';
import 'package:inventario_app/src/utils/params_model_util.dart';

class InventarioProvider extends ListProductProvider {
  int _currentPage = 0;
  final int _limit = 10;
  bool _isLoading = false;
  String _search = '';
  final String _orderProperty = 'fecha_creacion';
  final ProductsService _productsService = ProductsService();
  Timer? _debounce;

  InventarioProvider() {
    log('[InventarioProvider.init] - Inicializando provider');
    loadProductos();
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

  Future<void> _loadProducts({required bool reset}) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    if (reset) {
      currentPage = 0;
      products = [];
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

    final response = await _productsService.getProducts(params);

    if (response.isEmpty && !reset) {
      _currentPage--;
    } else {
      products = [...products, ...response];
    }

    isLoading = false;
    notifyListeners();
  }

  void loadProductos() {
    _loadProducts(reset: true);
  }

  void loadProductsNews() {
    _loadProducts(reset: isRefresh);
  }

  @override
  List<ProductModel> get productosFiltrados {
    if (_search.isEmpty) return products;

    return products.where((producto) {
      final nombre = producto.nombre.toLowerCase();
      final marca = producto.marca.toLowerCase();
      return nombre.contains(_search.toLowerCase()) ||
          marca.contains(_search.toLowerCase());
    }).toList();
  }

  void actualizarBusqueda(String valor) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search = valor;
      notifyListeners();
    });
  }
}
