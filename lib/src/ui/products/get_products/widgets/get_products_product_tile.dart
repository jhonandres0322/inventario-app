import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:inventario_app/src/ui/core/widgets/tile_info_card.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_screen.dart';

class GetProductsProductTile extends StatelessWidget {
  final Product product;
  const GetProductsProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
