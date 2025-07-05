import 'package:flutter/material.dart';
import 'package:inventario_app/src/providers/inventario_provider.dart';
import 'package:inventario_app/src/widgets/tile_producto_widget.dart';
import 'package:provider/provider.dart';

class InventarioScreen extends StatelessWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario MAD Store'),
        bottom: SearchProductsWidget(),
        actions: [Icon(Icons.shopping_bag)],
      ),
      body: ListProductsWidget(),
    );
  }
}

class SearchProductsWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchProductsWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }
}

class ListProductsWidget extends StatelessWidget {
  const ListProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<InventarioProvider>(context, listen: false);
    return FutureBuilder(
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
              final producto = productos[index];
              return TileProductoWidget(producto: producto);
            },
          ),
        );
      },
    );
  }
}
