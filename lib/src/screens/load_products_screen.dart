import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_routes.dart';
import 'package:inventario_app/src/providers/load_product_provider.dart';
import 'package:inventario_app/src/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class LoadProductsScreen extends StatelessWidget {
  const LoadProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final LoadProductProvider provider = Provider.of<LoadProductProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Cargar Producto')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: size.height * 0.08,
            left: size.width * 0.04,
            right: size.width * 0.04,
          ),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  keyboardType: TextInputType.text,
                  hintText: 'Ingrese el nombre o la referencia del producto ',
                  labelText: 'Nombre o Referencia',
                  validator: (value) => provider.validateReferenceForm(value),
                  onChanged: (value) => provider.setNameReferenceProduct(value),
                  value: provider.nameReferenceProduct,
                ),
                SizedBox(height: size.height * 0.03),
                TextFormFieldWidget(
                  keyboardType: TextInputType.number,
                  hintText: 'Ingrese precio de compra en Kliker',
                  labelText: 'Precio de Compra',
                  validator: (value) => provider.validateNumberForm(value),
                  onChanged: (value) => provider.setPriceProduct(value),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ButtonCategory(category: 'camisas'),
                    _ButtonCategory(category: 'pantalones'),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Talla',
                    hintText: 'Escoja la talla',
                  ),
                  value: provider.sizeSelected,
                  onChanged: provider.setSizeSelected,
                  items: provider.getSizes().map((size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size),
                    );
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
                        validator: (value) =>
                            provider.validateNumberForm(value),
                        onChanged: (value) {},
                        readOnly: true,
                        controller: provider.barcodeController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        provider.clearBarcode();
                        Navigator.pushNamed(
                          context,
                          AppRoutes.scanBarcodeScreen,
                        );
                      },
                      icon: Icon(
                        Icons.barcode_reader,
                        size: size.height * 0.06,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                TextFormFieldWidget(
                  hintText: 'Ingrese la cantidad en el inventario',
                  labelText: 'Cantidad',
                  validator: (value) => provider.validateNumberForm(value),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => provider.setQuantity(value),
                ),
                SizedBox(height: size.height * 0.03),
                SizedBox(
                  width: size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: !provider.disabledButtonSaveForm()
                        ? () {
                            provider.onSubmitForm();
                          }
                        : null,
                    child: Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonCategory extends StatelessWidget {
  const _ButtonCategory({required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final LoadProductProvider provider = Provider.of<LoadProductProvider>(
      context,
    );

    final bool isActive = provider.typeClothes == category;
    return ElevatedButton(
      onPressed: () {
        provider.setTypeClothes(category);
        provider.clearSizeSelected();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.indigo : Colors.grey[300],
        foregroundColor: isActive ? Colors.white : Colors.black,
      ),
      child: Text(category[0].toUpperCase() + category.substring(1)),
    );
  }
}
