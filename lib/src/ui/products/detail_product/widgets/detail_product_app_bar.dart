import 'package:flutter/material.dart';

import 'package:inventario_app/src/domain/products/models/product.dart';

class DetailProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailProductAppBar({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Tooltip(
        message: product.name,
        child: Text(product.name, style: TextStyle(fontSize: 18), maxLines: 2),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
