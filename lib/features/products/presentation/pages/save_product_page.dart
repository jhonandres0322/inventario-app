import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';
import 'package:inventario_app/features/products/presentation/providers/save_product_provider.dart';
import 'package:inventario_app/features/products/presentation/widgets/product_form_widget.dart';
import 'package:provider/provider.dart';

class SaveProductPage extends StatelessWidget {
  const SaveProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final getProductsProvider = Provider.of<GetProductsProvider>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider(
      create: (_) => SaveProductProvider(getProductsProvider),
      child: Scaffold(
        appBar: AppBar(title: const Text('Guardar Producto')),
        body: ProductFormWidget(),
      ),
    );
  }
}
