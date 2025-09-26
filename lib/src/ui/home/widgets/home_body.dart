import 'package:flutter/material.dart';

import 'package:inventario_app/src/config/routes/routes.dart';
import 'package:inventario_app/src/ui/core/widgets/icon_label_nav_button.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  final String _textAdmin = 'Administrador';
  final String _textGetProducts = 'Inventario';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconLabelNavButton(
            text: _textAdmin,
            icon: Icons.warehouse,
            routeTo: Routes.admin,
          ),
          IconLabelNavButton(
            text: _textGetProducts,
            icon: Icons.inventory,
            routeTo: Routes.getProducts,
          ),
        ],
      ),
    );
  }
}
