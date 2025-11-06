import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/services/image_share/image_share_service.dart';
import 'package:inventario_app/src/ui/products/catalog_products/viewmodels/catalog_products_provider.dart';
import 'package:provider/provider.dart';

class CatalogProductsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CatalogProductsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CatalogProductsProvider>();

    return AppBar(
      title: Text('Catalogo'),
      actions: [
        IconButton(
          onPressed: vm.selectedProducts.isNotEmpty
              ? () {
                  final List<String> imageUrls = vm.selectedProducts
                      .map((product) => product.images!.split(',').first)
                      .toList();
                  ImageShareService.shareImagesFromUrls(imageUrls, context);
                }
              : null,
          icon: Icon(Icons.share),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
