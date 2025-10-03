import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/services/image_share/image_share_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

class DetailProductFloatingActionButton extends StatelessWidget {
  const DetailProductFloatingActionButton({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.share),
      onPressed: () {
        ImageShareService.shareImageFromUrl(
          product.images!.split(',').first,
          context,
        );
      },
    );
  }
}
