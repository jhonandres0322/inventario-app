import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/widgets/snackbar_service.dart';
import 'package:inventario_app/src/ui/products/catalog_products/viewmodels/catalog_products_provider.dart';
import 'package:inventario_app/src/ui/products/catalog_products/widgets/catalog_products_grid_item.dart';
import 'package:provider/provider.dart';

class CatalogProductsBody extends StatelessWidget {
  const CatalogProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogProductsProvider>(
      builder: (context, vm, child) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (vm.showError) {
          SnackBarService.showErrorSnackBar(
            context,
            vm.messageError!,
            vm.resetState,
          );
        }
        if (vm.showSuccess) {
          SnackBarService.showSuccessSnackBar(
            context,
            vm.messageSuccess!,
            vm.resetState,
          );
        }
        if (vm.products.isEmpty) {
          return const Center(child: Text('Sin productos.'));
        }

        final Size size = MediaQuery.of(context).size;
        return Container(
          margin: EdgeInsets.all(size.height * 0.03),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: vm.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CatalogProductsGridItem(product: vm.products[index]);
            },
          ),
        );
      },
    );
  }
}
