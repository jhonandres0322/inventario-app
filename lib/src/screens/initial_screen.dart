import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_routes.dart';
import 'package:inventario_app/src/widgets/item_page_button_widget.dart'
    show ItemPageButton;

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Bienvenido a MAD Store',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            ItemPageButton(
              text: 'Administrador',
              icon: Icons.warehouse,
              routeTo: AppRoutes.admin,
            ),
            ItemPageButton(
              text: 'Inventario',
              icon: Icons.inventory,
              routeTo: AppRoutes.inventoryList,
            ),
          ],
        ),
      ),
    );
  }
}
