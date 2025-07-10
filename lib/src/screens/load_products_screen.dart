import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_routes.dart';
import 'package:inventario_app/src/core/app_sizes_clothes.dart';
import 'package:inventario_app/src/providers/load_product_provider.dart';
import 'package:inventario_app/src/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class LoadProductsScreen extends StatelessWidget {
  const LoadProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final LoadProductProvider loadProductProvider =
        Provider.of<LoadProductProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Cargar Producto')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: size.height * 0.08,
            left: size.width * 0.04,
            right: size.width * 0.04,
          ),
          child: Column(
            children: [
              TextFormFieldWidget(
                keyboardType: TextInputType.text,
                hintText: 'Ingrese el nombre o la referencia del producto ',
                labelText: 'Nombre o Referencia',
                readOnly: false,
                validator: (value) => null,
                onSaved: (value) => '',
              ),
              SizedBox(height: size.height * 0.03),
              TextFormFieldWidget(
                keyboardType: TextInputType.number,
                hintText: 'Ingrese precio de compra en Kliker',
                labelText: 'Precio de Compra',
                readOnly: false,
                validator: (value) => null,
                onSaved: (value) => '',
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ButtonCategory(category: 'camisas', isActive: false),
                  _ButtonCategory(category: 'pantalones', isActive: true),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              DropdownMenu<String>(
                width: size.width * 0.9,
                hintText: 'Escoja la talla',
                label: Text('Talla'),
                dropdownMenuEntries: AppSizesClothes().sizesNumber.map((size) {
                  return DropdownMenuEntry(value: size, label: size);
                }).toList(),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      hintText: '',
                      labelText: 'Código de Barras',
                      validator: null,
                      onSaved: (value) => '',
                      readOnly: true,
                      value: loadProductProvider.valueBarcode,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      loadProductProvider.clearBarcode();
                      Navigator.pushNamed(context, AppRoutes.scanBarcodeScreen);
                    },
                    icon: Icon(Icons.barcode_reader, size: size.height * 0.06),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              TextFormFieldWidget(
                hintText: 'Ingrese la cantidad en el inventario',
                labelText: 'Cantidad',
                validator: null,
                onSaved: (value) => {},
              ),
              SizedBox(height: size.height * 0.03),
              SizedBox(
                width: size.width * 0.9,
                child: ElevatedButton(onPressed: () {}, child: Text('Guardar')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonCategory extends StatelessWidget {
  const _ButtonCategory({required this.category, required this.isActive});

  final String category;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.indigo : Colors.grey[300],
        foregroundColor: isActive ? Colors.white : Colors.black,
      ),
      child: Text(category[0].toUpperCase() + category.substring(1)),
    );
  }
}
