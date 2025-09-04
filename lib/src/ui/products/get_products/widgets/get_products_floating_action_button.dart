import 'package:flutter/material.dart';

import 'package:inventario_app/src/config/routes/routes.dart';

class GetProductsFloatingActionButton extends StatelessWidget {
  const GetProductsFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.saveProduct);
      },
      shape: CircleBorder(),
      child: Icon(Icons.add),
    );
  }
}
