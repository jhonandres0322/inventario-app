import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';
import 'package:inventario_app/src/ui/products/get_products/widgets/get_products_product_tile.dart';

class GetProductsBody extends StatelessWidget {
  const GetProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GetProductsProvider>(
      builder: (_, vm, __) {
        if (vm.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (vm.error != null) {
          return Center(child: Text('Error: ${vm.error}'));
        }
        if (vm.filteredItems.isEmpty) {
          return const Center(child: Text('Sin productos.'));
        }
        final itemCount = vm.filteredItems.length + (vm.loadingMore ? 1 : 0);
        return ListView.builder(
          controller: vm.scrollController,
          itemCount: itemCount,
          itemBuilder: (_, i) {
            if (i < vm.filteredItems.length) {
              return GetProductsProductTile(product: vm.filteredItems[i]);
            }
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }
}
