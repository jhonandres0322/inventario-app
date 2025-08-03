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
                    Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return opciones.where((String option) {
                          return option.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          );
                        });
                      },
                      onSelected: (String selection) {
                        debugPrint('Seleccionado: $selection');
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            return TextFormField(
                              controller: controller,
                              focusNode: focusNode,
                              decoration: InputDecoration(
                                labelText: 'Fruta',
                                border: OutlineInputBorder(),
                              ),
                            );
                          },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
