import 'package:flutter/material.dart';

import 'package:inventario_app/src/ui/core/ui/generic_search_bar.dart';
import 'package:inventario_app/src/ui/products/get_products/widgets/get_products_body.dart';
import 'package:inventario_app/src/ui/products/get_products/widgets/get_products_floating_action_button.dart';

class GetProductsScreen extends StatelessWidget {
  const GetProductsScreen({super.key});

  final String _textTitle = 'Inventario';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_textTitle), bottom: GenericSearchBar()),
      body: const GetProductsBody(),
      floatingActionButton: GetProductsFloatingActionButton(),
    );
  }
}
