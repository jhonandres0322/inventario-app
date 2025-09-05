import 'package:flutter/material.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

class DetailProductFloatingActionButton extends StatelessWidget {
  const DetailProductFloatingActionButton({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FloatingActionButton.extended(
      onPressed: () => _showEditProductModal(context, product),
      label: Row(
        children: [
          Icon(Icons.edit),
          SizedBox(width: size.width * 0.01),
          Text('Editar'),
        ],
      ),
    );
  }

  void _showEditProductModal(BuildContext context, Product productToUpdate) {}
}
