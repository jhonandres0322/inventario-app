import 'package:flutter/material.dart';
import 'package:inventario_app/src/screens/add_sale_screen.dart';
import 'package:inventario_app/src/screens/admin_screen.dart';
import 'package:inventario_app/src/screens/customers_screen.dart';
import 'package:inventario_app/src/screens/initial_screen.dart';
import 'package:inventario_app/src/screens/inventory_list_screen.dart';
import 'package:inventario_app/src/screens/load_products_screen.dart';

class AppRoutes {
  static const String initial = '/initial';
  static const String admin = '/admin';
  static const String inventoryList = '/invetory-list';
  static const String loadProducts = '/load-products';
  static const String addSale = '/add-sale';
  static const String customers = '/customers';

  Map<String, WidgetBuilder> get routes {
    return {
      inventoryList: (context) => InventarioScreen(),
      initial: (context) => InitialScreen(),
      admin: (context) => AdminScreen(),
      loadProducts: (context) => LoadProductsScreen(),
      addSale: (context) => AddSaleScreen(),
      customers: (context) => CustomersScreen(),
    };
  }
}
