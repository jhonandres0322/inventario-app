import 'package:flutter/material.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/detail_product/viewmodels/detail_product_provider.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_images.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_info.dart';
import 'package:provider/provider.dart';

class DetailProductBody extends StatelessWidget {
  const DetailProductBody({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<String> images = product.images!.split(",");

    return Consumer<DetailProductProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.showError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${provider.error}')));
            provider.resetState();
          });
        }
        if (provider.showSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Producto eliminado con éxito')),
            );
            provider.resetState();
          });
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailProductImages(images: images),
            SizedBox(height: size.height * 0.05),
            DetailProductInfo(product: product),
          ],
        );
      },
    );
  }
}
