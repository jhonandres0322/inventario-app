import 'package:flutter/material.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';
import 'package:inventario_app/src/ui/products/detail_product/viewmodels/detail_product_provider.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_modal_delete.dart';
import 'package:provider/provider.dart';

class DetailProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailProductAppBar({super.key, required this.product});

  final double height = 48;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final DetailProductProvider provider = Provider.of<DetailProductProvider>(
      context,
    );
    final Size size = MediaQuery.of(context).size;
    return AppBar(
      title: Tooltip(
        message: product.name,
        child: Text(product.name, overflow: TextOverflow.ellipsis),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _showConfirmForDelete(
              context: context,
              onConfirm: () => provider.deleteProduct(product),
              onDoneRedirect: () => Navigator.pop(context),
            );
          },
          icon: Icon(Icons.delete, color: AppColors().textAppBar),
          highlightColor: AppColors().textAppBar,
        ),
        SizedBox(width: size.width * 0.01),
      ],
    );
  }

  Future<void> _showConfirmForDelete({
    required BuildContext context,
    required Future<void> Function() onConfirm,
    required VoidCallback onDoneRedirect,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return DetailProductModalDelete();
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

    // ignore: use_build_context_synchronously
    onDoneRedirect();
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
