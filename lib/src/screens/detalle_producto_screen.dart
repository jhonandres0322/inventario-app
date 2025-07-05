import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/producto_model.dart';

class DetalleProductoScreen extends StatelessWidget {
  const DetalleProductoScreen({super.key, required this.producto});

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    final List<String> imagenes = [producto.foto1, producto.foto2];
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(producto.nombre)),
      body: Column(
        children: [
          // Carrusel con PageView
          SizedBox(
            height: size.height * 0.5,
            child: PageView.builder(
              itemCount: imagenes.length,
              controller: PageController(viewportFraction: 0.9),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imagenes[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                );
              },
            ),
          ),

          // Información del producto
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Talla: ${producto.talla}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Marca: ${producto.marca}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Precio: \$${producto.precio}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Cantidad disponible: ${producto.cantidad}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
