import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventario_app/src/models/product_model.dart';

class DetalleProductoScreen extends StatelessWidget {
  const DetalleProductoScreen({super.key, required this.producto});

  final ProductModel producto;

  @override
  Widget build(BuildContext context) {
    final List<String> imagenes = [
      if (producto.foto1.isNotEmpty) producto.foto1,
      if (producto.foto2.isNotEmpty) producto.foto2,
    ];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(producto.nombre)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: size.height * 0.02),
            height: size.height * 0.4,
            child: PageView.builder(
              itemCount: imagenes.length,
              controller: PageController(viewportFraction: 0.9),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imagenes[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(Icons.broken_image, size: 100),
                          ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: size.height * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.straighten, 'Talla', producto.talla),
                    const Divider(),
                    _buildInfoRow(Icons.store, 'Marca', producto.marca),
                    const Divider(),
                    _buildInfoRow(
                      Icons.price_check,
                      'Precio',
                      NumberFormat.currency(
                        locale: 'es_CO',
                        symbol: '\$',
                        decimalDigits: 0,
                      ).format(double.parse(producto.precioCompra)),
                    ),
                    const Divider(),
                    _buildInfoRow(
                      Icons.inventory_2,
                      'Cantidad disponible',
                      producto.cantidad,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
