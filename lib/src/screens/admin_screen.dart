import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_routes.dart';
import 'package:inventario_app/src/widgets/item_page_button_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel de Administración')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ItemPageButton(
              text: 'Cargar Producto',
              icon: Icons.add,
              routeTo: AppRoutes.loadProducts,
            ),
            ItemPageButton(
              text: 'Agregar Venta',
              icon: Icons.sell,
              routeTo: AppRoutes.addSale,
            ),
            ItemPageButton(
              text: 'Clientes',
              icon: Icons.group,
              routeTo: AppRoutes.customers,
            ),
          ],
        ),
      ),
    );
  }
}
