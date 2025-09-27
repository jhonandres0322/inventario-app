import 'package:flutter/material.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/detail_product/viewmodels/detail_product_provider.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_app_bar.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_body.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends StatelessWidget {
  const DetailProductScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final getProductsProvider = Provider.of<GetProductsProvider>(
      context,
      listen: false,
    );
    return ChangeNotifierProvider(
      create: (_) => DetailProductProvider(getProductsProvider),
      child: Scaffold(
        appBar: DetailProductAppBar(product: product),
        body: DetailProductBody(product: product),
      ),
    );
  }
}
