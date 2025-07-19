import 'dart:developer';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/providers/list_product_provider.dart';
import 'package:inventario_app/src/services/products_service.dart';
import 'package:inventario_app/src/utils/params_model_util.dart';

class InventarioProvider extends ListProductProvider {
  int _currentPage = 0;
  final int _limit = 10;
  bool _isLoading = false;
  String _search = '';
  final String _orderProperty = 'nombre';
  final ProductsService _productsService = ProductsService();

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

  void loadProductos() async {
    if (isLoading) true;
    final int from = _currentPage * _limit;
    final int to = from + _limit + 1;
    ParamsModelUtil params = ParamsModelUtil(
      from: from,
      to: to,
      orderProperty: _orderProperty,
      isOrderAscending: true,
    );

    final response = await _productsService.getProducts(params);
    products = [...products, ...response];
    isLoading = false;
    notifyListeners();
  }

  void loadProductsNews() async {
    if (isLoading) return;
    if (isRefresh) {
      currentPage = 0;
      products = [];
      isRefresh = false;
    } else {
      currentPage++;
    }

    isLoading = true;
    final int from = _currentPage * _limit;
    final int to = from + _limit + 1;
    ParamsModelUtil params = ParamsModelUtil(
      from: from,
      to: to,
      orderProperty: _orderProperty,
      isOrderAscending: true,
    );

    final response = await _productsService.getProducts(params);
    // final response = [];
    if (response.isEmpty) {
      _currentPage--;
    }
    products = [...products, ...response];
    isLoading = false;
    notifyListeners();
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
    _search = valor;
    notifyListeners();
  }
}
