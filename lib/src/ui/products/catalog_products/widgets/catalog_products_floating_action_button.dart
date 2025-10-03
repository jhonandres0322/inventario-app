import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventario_app/src/ui/products/catalog_products/viewmodels/catalog_products_provider.dart';

class CatalogProductsFloatingActionButton extends StatelessWidget {
  const CatalogProductsFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatalogProductsProvider>(context);

    return FloatingActionButton(
      elevation: 2,
      onPressed: () {
        if (!provider.scaffoldKey.currentState!.isDrawerOpen) {
          provider.scaffoldKey.currentState?.openDrawer();
        } else {
          provider.scaffoldKey.currentState?.closeDrawer();
        }
      },
      shape: CircleBorder(),
      child: Icon(Icons.filter_alt),
    );
  }
}
