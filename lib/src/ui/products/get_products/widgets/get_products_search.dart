import 'package:flutter/material.dart';

import 'package:inventario_app/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/ui/core/ui/generic_search_bar.dart';

class GetProductsSearch extends StatelessWidget {
  const GetProductsSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericSearchBar<Product>(
      hintText: 'Buscar productos...',
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
    );
  }
}
