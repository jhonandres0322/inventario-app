import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/customers/get_customers/widgets/get_customers_floating_action_button.dart';

class GetCustomersScreen extends StatelessWidget {
  const GetCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: GetCustomersFloatingActionButton());
  }
}
