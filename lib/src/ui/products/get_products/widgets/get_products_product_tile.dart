import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:inventario_app/src/ui/core/widgets/tile_info_card.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_screen.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';
import 'package:inventario_app/src/ui/products/get_products/widgets/get_products_modal_delete.dart';
import 'package:provider/provider.dart';

class GetProductsProductTile extends StatelessWidget {
  final Product product;
  const GetProductsProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetProductsProvider>(context, listen: false);
    return TileInfoCard(
      title: product.name,
      infoItems: [
        InfoItem(Icons.store, product.brand),
        InfoItem(Icons.straighten, product.size.toUpperCase()),
      ],
      trailingItems: [
        InfoItem(
          Icons.attach_money,
          NumberFormat.currency(
            locale: 'en_US',
            symbol: '\$',
            decimalDigits: 0,
          ).format(product.purchasePrice),
        ),
        InfoItem(Icons.inventory_2, product.quantity.toString()),
      ],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductScreen(product: product),
          ),
        );
      },
      onLongPress: () {
        _showConfirmForDelete(
          context: context,
          onConfirm: () => provider.deleteProduct(product),
        );
      },
    );
  }

  Future<void> _showConfirmForDelete({
    required BuildContext context,

    required Future<void> Function() onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return GetProductsModalDelete();
      },
    );
    if (confirmed != true) return;

    try {
      await onConfirm();
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();

      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));

      return;
    }
  }
}
