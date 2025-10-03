import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/products/catalog_products/viewmodels/catalog_products_provider.dart';
import 'package:inventario_app/src/ui/products/catalog_products/widgets/catalog_products_body.dart';
import 'package:inventario_app/src/ui/products/catalog_products/widgets/catalog_products_bottom_navigator_bar.dart';
import 'package:inventario_app/src/ui/products/catalog_products/widgets/catalog_products_drawer.dart';
import 'package:inventario_app/src/ui/products/catalog_products/widgets/catalog_products_floating_action_button.dart';
import 'package:provider/provider.dart';

class CatalogProductsScreen extends StatelessWidget {
  const CatalogProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatalogProductsProvider>(context);

    return Scaffold(
      key: provider.scaffoldKey,
      body: CatalogProductsBody(),
      bottomNavigationBar: CatalogProductsBottomNavigatorBar(),
      drawer: CatalogProductsDrawer(),
      floatingActionButton: CatalogProductsFloatingActionButton(),
    );
  }
}
