import 'package:flutter/material.dart';
import 'package:inventario_app/src/providers/add_sale_provider.dart';
import 'package:provider/provider.dart';

class AddSaleScreen extends StatelessWidget {
  const AddSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Añadir Venta')),
      body: _MainFormAddSale(),
    );
  }
}

class _MainFormAddSale extends StatelessWidget {
  _MainFormAddSale();

  final List<String> opciones = [
    'Manzana',
    'Banana',
    'Cereza',
    'Durazno',
    'Uva',
  ];
  @override
  Widget build(BuildContext context) {
    final AddSaleProvider provider = Provider.of<AddSaleProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return provider.isLoading &&
            provider.customers.isEmpty &&
            provider.products.isEmpty
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () => provider.loadAll(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Form(
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Producto',
                        hintText: 'Selecciona el producto',
                      ),
                      items: provider.products.map((product) {
                        return DropdownMenuItem(
                          value: product.id,
                          child: Text(product.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                    SizedBox(height: size.height * 0.03),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Clientes',
                        hintText: 'Selecciona el cliente',
                      ),
                      items: provider.customers.map((customer) {
                        return DropdownMenuItem(
                          value: customer.id,
                          child: Text(customer.nombre),
                        );
                      }).toList(),
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
