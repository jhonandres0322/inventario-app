import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';

class DetailProductInfo extends StatelessWidget {
  const DetailProductInfo({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    );
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Card(
        color: AppColors().secondary,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInfoRow(
                Icons.straighten,
                'Talla',
                product.size.toUpperCase(),
              ),
              const Divider(),
              _buildInfoRow(Icons.store, 'Marca', product.brand),
              const Divider(),
              _buildInfoRow(
                Icons.price_check,
                'Precio',
                formatter.format(product.purchasePrice),
              ),
              const Divider(),
              _buildInfoRow(
                Icons.inventory_2,
                'Cantidad disponible',
                product.quantity.toString(),
              ),
              const Divider(),
              _buildInfoRow(
                Icons.price_check,
                'Costo Real',
                formatter.format(product.actualCost),
              ),
              const Divider(),
              _buildInfoRow(
                Icons.price_check,
                'Comisión',
                formatter.format(product.commission),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors().primary),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors().primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 18, color: AppColors().primary),
          ),
        ),
      ],
    );
  }
}
