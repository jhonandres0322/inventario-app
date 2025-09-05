import 'package:flutter/material.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_images.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_info.dart';

class DetailProductBody extends StatelessWidget {
  const DetailProductBody({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<String> images = product.images.split(",");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailProductImages(images: images),
        SizedBox(height: size.height * 0.05),
        DetailProductInfo(product: product),
      ],
    );
  }
}
