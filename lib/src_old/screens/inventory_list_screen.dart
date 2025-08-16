import 'package:flutter/material.dart';
import 'package:inventario_app/src_old/providers/inventario_provider.dart';
import 'package:inventario_app/src_old/widgets/list_products_widget.dart';
import 'package:provider/provider.dart';

class InventarioScreen extends StatelessWidget {
  const InventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final InventarioProvider provider = Provider.of<InventarioProvider>(
      context,
    );
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          provider.clearValueSearch();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          bottom: SearchProductsWidget(),
          title: Text('Inventario MAD Store'),
          toolbarHeight: size.height * 0.08,
          automaticallyImplyLeading: false,
        ),
        body: Builder(
          builder: (context) {
            return SizedBox.expand(child: _ListProducts());
          },
        ),
      ),
    );
  }
}

class _ListProducts extends StatelessWidget {
  const _ListProducts();

  @override
  Widget build(BuildContext context) {
    final InventarioProvider provider = Provider.of<InventarioProvider>(
      context,
    );
    return ListProductsWidget(
      onNextPage: () => provider.loadProductsNews(),
      products: provider.productosFiltrados,
      provider: provider,
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
