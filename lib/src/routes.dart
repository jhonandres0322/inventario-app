import 'package:flutter/material.dart';
import 'package:inventario_app/features/customers/presentation/pages/get_customers_page.dart';
import 'package:inventario_app/src/ui/home/widgets/home_screen.dart';
import 'package:inventario_app/src/ui/products/get_products/widgets/get_products_screen.dart';
import 'package:inventario_app/features/products/presentation/pages/save_product_page.dart';
import 'package:inventario_app/features/sales/presentation/pages/save_sale_page.dart';
import 'package:inventario_app/src/ui/admin/widgets/admin_screen.dart';

class Routes {
  static const home = '/';
  static const admin = '/admin';
  static const getProducts = '/get-products';
  static const saveProduct = '/save-product';
  static const saveSale = '/save-sale';
  static const getCustomers = '/get-customers';

  static Map<String, WidgetBuilder> get map => {
    home: (_) => const HomeScreen(),
    admin: (_) => const AdminScreen(),
    getProducts: (_) => const GetProductsScreen(),
    saveProduct: (_) => const SaveProductPage(),
    saveSale: (_) => const SaveSalePage(),
    getCustomers: (_) => const GetCustomersPage(),
  };
}
