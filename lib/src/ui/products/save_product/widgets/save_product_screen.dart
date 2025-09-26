import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';
import 'package:inventario_app/src/ui/products/save_product/viewmodels/save_product_provider.dart';
import 'package:inventario_app/src/ui/products/save_product/widgets/save_product_form.dart';

class SaveProductScreen extends StatelessWidget {
  const SaveProductScreen({super.key});

  final String textTitle = 'Guardar Producto';
  @override
  Widget build(BuildContext context) {
    final getProductsProvider = Provider.of<GetProductsProvider>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider(
      create: (_) => SaveProductProvider(getProductsProvider),
      child: Scaffold(
        appBar: AppBar(title: Text(textTitle)),
        body: SaveProductForm(),
      ),
    );
  }
}
