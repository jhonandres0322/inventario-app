import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/producto_model.dart';
import 'package:inventario_app/src/screens/detalle_producto_screen.dart';

class TileProductoWidget extends StatelessWidget {
  const TileProductoWidget({super.key, required this.producto});

  final Producto producto;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurpleAccent.shade100),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.01,
      ),
      child: ListTile(
        title: Text('${producto.nombre} (${producto.talla})'),
        subtitle: Text('${producto.marca} - \$${producto.precio}'),
        trailing: Text('Stock: ${producto.cantidad}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalleProductoScreen(producto: producto),
            ),
          );
        },
      ),
    );
  }
}
