import 'package:flutter/material.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_app_bar.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_body.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_floating_action_button.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailProductAppBar(productName: product.name),
      body: DetailProductBody(product: product),
      floatingActionButton: DetailProductFloatingActionButton(product: product),
    );
  }
}
