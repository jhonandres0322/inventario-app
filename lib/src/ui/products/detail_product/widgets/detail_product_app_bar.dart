import 'package:flutter/material.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/products/detail_product/viewmodels/detail_product_provider.dart';
import 'package:inventario_app/src/ui/products/detail_product/widgets/detail_product_modal_delete.dart';
import 'package:provider/provider.dart';

class DetailProductAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DetailProductAppBar({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final DetailProductProvider provider = Provider.of<DetailProductProvider>(
      context,
    );
    final Size size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Tooltip(
        message: product.name,
        child: Text(product.name, style: TextStyle(fontSize: 18), maxLines: 2),
      ),
      // actions: [
      //   IconButton(
      //     onPressed: () {
      //       _showConfirmForDelete(
      //         context: context,
      //         onConfirm: () => provider.deleteProduct(product),
      //         onDoneRedirect: () => Navigator.pop(context),
      //       );
      //     },
      //     icon: Icon(Icons.delete, color: AppColors().textAppBar),
      //     highlightColor: AppColors().textAppBar,
      //   ),
      //   SizedBox(width: size.width * 0.01),
      // ],
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
    onDoneRedirect();
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
