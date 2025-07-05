import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/producto_model.dart';
import 'package:inventario_app/src/services/google_sheets_service.dart';

class InventarioProvider with ChangeNotifier {
  List<Producto> _productos = [];
  String? _error;
  String _busqueda = '';

  List<Producto> get productos => _productos;
  String? get error => _error;

  Future<void> loadProductos() async {
    try {
      _error = null;
      _productos = await GoogleSheetsService.fetchProductos();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  List<Producto> get productosFiltrados {
    if (_busqueda.isEmpty) return _productos;

    return _productos.where((producto) {
      final nombre = producto.nombre.toLowerCase();
      final marca = producto.marca.toLowerCase();
      return nombre.contains(_busqueda.toLowerCase()) ||
          marca.contains(_busqueda.toLowerCase());
    }).toList();
  }

  void actualizarBusqueda(String valor) {
    _busqueda = valor;
    notifyListeners();
  }
}
