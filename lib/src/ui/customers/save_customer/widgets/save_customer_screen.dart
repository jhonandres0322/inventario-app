import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inventario_app/src/ui/customers/save_customer/viewmodels/save_customer_provider.dart';
import 'package:inventario_app/src/ui/customers/save_customer/widgets/save_customer_form.dart';

class SaveCustomerScreen extends StatelessWidget {
  const SaveCustomerScreen({super.key});

  final String textTitle = 'Crear cliente';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaveCustomerProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text(textTitle)),
        body: SaveCustomerForm(),
      ),
    );
  }
}
