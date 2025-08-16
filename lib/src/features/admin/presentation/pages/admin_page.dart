import 'package:flutter/material.dart';
import 'package:inventario_app/src/routes.dart';
import 'package:inventario_app/src/shared/presentation/widgets/icon_label_nav_button.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel de Administración')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconLabelNavButton(
              text: 'Cargar Producto',
              icon: Icons.sell,
              routeTo: Routes.saveProduct,
            ),
            IconLabelNavButton(
              text: 'Crear Venta',
              icon: Icons.shopping_cart,
              routeTo: Routes.saveSale,
            ),
            IconLabelNavButton(
              text: 'Listado de Clientes',
              icon: Icons.group,
              routeTo: Routes.getCustomers,
            ),
          ],
        ),
      ),
    );
  }
}
