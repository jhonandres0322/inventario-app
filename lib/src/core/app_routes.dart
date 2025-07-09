import 'package:flutter/material.dart';
import 'package:inventario_app/src/screens/admin_screen.dart';
import 'package:inventario_app/src/screens/initial_screen.dart';
import 'package:inventario_app/src/screens/inventory_list_screen.dart';

class AppRoutes {
  static const String addPrendaInventario = '/add-prenda-inventario';
  static const String initial = '/initial';
  static const String admin = '/admin';
  static const String inventoryList = '/invetory-list';

  Map<String, WidgetBuilder> get routes {
    return {
      inventoryList: (context) => InventarioScreen(),
      initial: (context) => InitialScreen(),
      admin: (context) => AdminScreen(),
    };
  }
}
