import 'package:flutter/material.dart';
import 'package:inventario_app/src/routes.dart';
import 'package:inventario_app/src/shared/presentation/widgets/icon_label_nav_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenido a MAD Store')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconLabelNavButton(
              text: 'Administrador',
              icon: Icons.warehouse,
              routeTo: Routes.admin,
            ),
            IconLabelNavButton(
              text: 'Inventario',
              icon: Icons.inventory,
              routeTo: Routes.getProducts,
            ),
          ],
        ),
      ),
    );
  }
}
