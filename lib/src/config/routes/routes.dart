import 'package:flutter/material.dart';

import 'package:inventario_app/src/ui/customers/get_customers/widgets/get_customers_screen.dart';
import 'package:inventario_app/src/ui/customers/save_customer/widgets/save_customer_screen.dart';
import 'package:inventario_app/src/ui/home/widgets/home_screen.dart';
import 'package:inventario_app/src/ui/products/download_product/widgets/download_product_screen.dart';
import 'package:inventario_app/src/ui/products/get_products/widgets/get_products_screen.dart';
import 'package:inventario_app/src/ui/admin/widgets/admin_screen.dart';
import 'package:inventario_app/src/ui/products/save_product/widgets/save_product_screen.dart';
import 'package:inventario_app/src/ui/products/update_product/widgets/update_product_screen.dart';

class Routes {
  static const home = '/';
  static const admin = '/admin';
  static const getProducts = '/get-products';
  static const saveProduct = '/save-product';
  static const saveSale = '/save-sale';
  static const getCustomers = '/get-customers';
  static const saveCustomer = '/save-customer';
  static const downloadProduct = '/download-product';
  static const updateProduct = '/update-product';

  static Map<String, WidgetBuilder> get map => {
    home: (_) => const HomeScreen(),
    admin: (_) => const AdminScreen(),
    getProducts: (_) => const GetProductsScreen(),
    saveProduct: (_) => const SaveProductScreen(),
    getCustomers: (_) => const GetCustomersScreen(),
    saveCustomer: (_) => const SaveCustomerScreen(),
    downloadProduct: (_) => const DownloadProductScreen(),
    updateProduct: (_) => const UpdateProductScreen(),
  };
}
