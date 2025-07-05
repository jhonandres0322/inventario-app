import 'package:flutter/material.dart';
import 'package:inventario_app/src/screens/inventario_screen.dart';

class AppRoutes {
  static const String home = '/inventario';
  static const String addPrendaInventario = '/add-prenda-inventario';

  Map<String, WidgetBuilder> get routes {
    return {home: (context) => InventarioScreen()};
  }
}
