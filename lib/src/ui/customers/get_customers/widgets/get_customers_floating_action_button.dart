import 'package:flutter/material.dart';

import 'package:inventario_app/src/config/routes/routes.dart';

class GetCustomersFloatingActionButton extends StatelessWidget {
  const GetCustomersFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.saveCustomer);
      },
      shape: CircleBorder(),
      child: Icon(Icons.add),
    );
  }
}
