import 'package:flutter/material.dart';

import 'package:inventario_app/src/routes.dart';
import 'package:inventario_app/src/ui/core/ui/icon_label_nav_button.dart';

class AdminBody extends StatelessWidget {
  const AdminBody({super.key});

  final String _textSaveProduct = 'Cargar Producto';
  final String _textSaveSale = 'Crear venta';
  final String _textGetCustomers = 'Clientes';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconLabelNavButton(
            text: _textSaveProduct,
            icon: Icons.sell,
            routeTo: Routes.saveProduct,
          ),
          IconLabelNavButton(
            text: _textSaveSale,
            icon: Icons.shopping_cart,
            routeTo: Routes.saveSale,
          ),
          IconLabelNavButton(
            text: _textGetCustomers,
            icon: Icons.group,
            routeTo: Routes.getCustomers,
          ),
        ],
      ),
    );
  }
}
