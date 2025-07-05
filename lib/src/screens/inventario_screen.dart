import 'package:flutter/material.dart';
import 'package:inventario_app/src/providers/inventario_provider.dart';
import 'package:inventario_app/src/screens/detalle_producto_screen.dart';
import 'package:provider/provider.dart';

class InventarioScreen extends StatelessWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventarioProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => Provider.of<InventarioProvider>(
                context,
                listen: false,
              ).actualizarBusqueda(value),
              decoration: InputDecoration(
                hintText: 'Buscar por nombre o marca',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: provider.loadProductos(),
        builder: (context, snapshot) {
          final providerWatch = Provider.of<InventarioProvider>(context);

          if (snapshot.connectionState == ConnectionState.waiting &&
              providerWatch.productos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (providerWatch.error != null) {
            return Center(child: Text('Error: ${providerWatch.error}'));
          }

          final productos = providerWatch.productosFiltrados;

          if (productos.isEmpty) {
            return const Center(child: Text('No se encontraron productos.'));
          }

          return RefreshIndicator(
            onRefresh: () => providerWatch.loadProductos(),
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final p = productos[index];
                return ListTile(
                  title: Text('${p.nombre} (${p.talla})'),
                  subtitle: Text('${p.marca} - \$${p.precio}'),
                  trailing: Text('Stock: ${p.cantidad}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetalleProductoScreen(producto: p),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
