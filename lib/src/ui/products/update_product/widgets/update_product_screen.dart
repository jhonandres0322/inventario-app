import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';
import 'package:inventario_app/src/ui/products/update_product/viewmodels/update_product_provider.dart';
import 'package:inventario_app/src/ui/products/update_product/widgets/update_product_bottom_navigator_bar.dart';
import 'package:inventario_app/src/ui/products/update_product/widgets/update_product_form.dart';
import 'package:provider/provider.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final getProductsProvider = Provider.of<GetProductsProvider>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider(
      create: (_) => UpdateProductProvider(getProductsProvider),
      child: Scaffold(
        appBar: AppBar(title: Text('Actualizar Producto')),
        body: UpdateProductForm(),
        bottomNavigationBar: UpdateProductBottomNavigatorBar(),
      ),
    );
  }
}
