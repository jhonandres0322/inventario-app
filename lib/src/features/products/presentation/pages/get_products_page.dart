import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/vo/brand/brand.dart';
import 'package:inventario_app/src/features/products/presentation/providers/get_products_provider.dart';
import 'package:inventario_app/src/routes.dart';
import 'package:inventario_app/src/shared/presentation/widgets/generic_search_bar.dart';
import 'package:inventario_app/src/shared/presentation/widgets/tile_info_card.dart';
import 'package:provider/provider.dart';

class GetProductsPage extends StatelessWidget {
  const GetProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        bottom: GenericSearchBar<Product>(
          hintText: 'Buscar productos...',
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
        ),
      ),
      body: const _Body(),
      floatingActionButton: _FloatingActionButton(),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
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

class _Body extends StatelessWidget {
  const _Body();

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
              return _ProductTile(product: vm.filteredItems[i]);
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

class _ProductTile extends StatelessWidget {
  final Product product;
  const _ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return TileInfoCard(
      title: product.name,
      infoItems: [
        InfoItem(Icons.store, product.brand.label),
        InfoItem(Icons.straighten, product.size.label),
      ],
      trailingItems: [
        InfoItem(
          Icons.attach_money,
          NumberFormat.currency(
            locale: 'es_CO',
            symbol: '\$',
            decimalDigits: 0,
          ).format(product.purchasePrice),
        ),
        InfoItem(Icons.inventory_2, product.quantity.toString()),
      ],
      onTap: () {},
    );
  }
}
