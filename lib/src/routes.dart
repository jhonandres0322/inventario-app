import 'package:flutter/material.dart';
import 'package:inventario_app/src/features/admin/presentation/pages/admin_page.dart';
import 'package:inventario_app/src/features/customers/presentation/pages/get_customers_page.dart';
import 'package:inventario_app/src/features/home/presentation/pages/home_page.dart';
import 'package:inventario_app/src/features/products/presentation/pages/get_products_page.dart';
import 'package:inventario_app/src/features/products/presentation/pages/save_product_page.dart';
import 'package:inventario_app/src/features/sales/presentation/pages/save_sale_page.dart';

class Routes {
  static const home = '/';
  static const admin = '/admin';
  static const getProducts = '/get-products';
  static const saveProduct = '/save-product';
  static const saveSale = '/save-sale';
  static const getCustomers = '/get-customers';

  static Map<String, WidgetBuilder> get map => {
    home: (_) => const HomePage(),
    admin: (_) => const AdminPage(),
    getProducts: (_) => const GetProductsPage(),
    saveProduct: (_) => const SaveProductPage(),
    saveSale: (_) => const SaveSalePage(),
    getCustomers: (_) => const GetCustomersPage(),
  };
}
