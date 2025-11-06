import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_screen.dart';
import 'package:inventario_app/src/ui/products/catalog_products/viewmodels/catalog_products_provider.dart';
import 'package:provider/provider.dart';

class CatalogProductsGridItem extends StatelessWidget {
  const CatalogProductsGridItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final vm = context.watch<CatalogProductsProvider>();

    final bool isSelected = vm.isSelected(product);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProductScreen(product: product),
          ),
        );
      },
      onLongPress: () {
        vm.toggleSelection(product);
      },
      child: Card(
        elevation: isSelected ? 6 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: isSelected ? AppColors().secondary : Colors.transparent,
            width: 2,
          ),
        ),
        // ignore: deprecated_member_use
        color: isSelected
            // ignore: deprecated_member_use
            ? AppColors().secondary.withOpacity(0.1)
            : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: product.images!.split(',').first,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.broken_image, size: 100),
                    ),
                    memCacheHeight: (size.height * 0.4).round(),
                  ),
                  if (isSelected)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        Icons.check_circle,
                        color: AppColors().secondary,
                        size: 24,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
