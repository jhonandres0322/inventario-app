import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/barcode/scan/widgets/barcode_scan_screen.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_dropdown_button_form_field.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_text_form_field.dart';
import 'package:inventario_app/src/ui/products/save_product/viewmodels/save_product_provider.dart';
import 'package:inventario_app/src_old/screens/scan_barcode_screen.dart';
import 'package:provider/provider.dart';

class SaveProductForm extends StatelessWidget {
  SaveProductForm({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<SaveProductProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${provider.error}')));
          });
        }
        if (provider.savedProduct != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Producto guardado con éxito')),
            );
          });
        }
        final double spaceBetween = size.height * 0.02;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: spaceBetween),
                  GenericTextFormField(
                    controller: nameController,
                    label: 'Nombre o Referencia',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      if (value.length < 3) {
                        return 'El nombre debe tener al menos 3 caracteres';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spaceBetween),
                  GenericTextFormField(
                    controller: purchasePriceController,
                    label: 'Precio de compra',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El precio es requerido';
                      }
                      final price = double.tryParse(value);
                      if (price == null) return 'Debe ser un número válido';
                      if (price < 0) return 'El precio no puede ser negativo';
                      if (value.startsWith('0') &&
                          !value.startsWith('0.') &&
                          value != '0') {
                        return 'No se permiten ceros a la izquierda';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spaceBetween),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GenericTextFormField(
                          controller: barcodeController,
                          label: 'Código de barras',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'El código de barras es requerido';
                            }
                            return null;
                          },
                          readOnly: true,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BarcodeScanScreen(
                                onBarcodeScanned: (barcode) {
                                  barcodeController.text = barcode;
                                },
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.barcode_reader),
                        iconSize: size.height * 0.05,
                      ),
                    ],
                  ),
                  SizedBox(height: spaceBetween),
                  GenericTextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    label: 'Cantidad',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La cantidad es requerida';
                      }
                      final price = double.tryParse(value);
                      if (price == null) return 'Debe ser un número válido';
                      if (price < 0) return 'La cantidad no puede ser negativa';
                      if (value.startsWith('0') &&
                          !value.startsWith('0.') &&
                          value != '0') {
                        return 'No se permiten ceros a la izquierda';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spaceBetween),
                  GenericDropdownButtonFormField(
                    label: 'Tipo de Ropa',
                    items: provider.categories,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El tipo de ropa es requerido';
                      }
                      return null;
                    },
                    onChanged: (value) => provider.categorySelected = value,
                  ),
                  SizedBox(height: spaceBetween),
                  GenericDropdownButtonFormField(
                    label: 'Talla',
                    items: provider.getSizes(),
                    onChanged: (value) => provider.sizeSelected = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La talla es requerida';
                      }
                      return null;
                    },
                    value: provider.getSizes().contains(provider.sizeSelected)
                        ? provider.sizeSelected
                        : null,
                  ),
                  SizedBox(height: spaceBetween),
                  GenericDropdownButtonFormField(
                    label: 'Marca',
                    items: provider.brands,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La marca es requerida';
                      }
                      return null;
                    },
                    onChanged: (value) => provider.brandSelected = value,
                  ),
                  SizedBox(height: spaceBetween),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        provider.saveProduct(
                          name: nameController.text,
                          barcode: barcodeController.text,
                          purchasePrice: purchasePriceController.text,
                          quantity: quantityController.text,
                          brand: provider.brandSelected!,
                          size: provider.sizeSelected!,
                          category: provider.categorySelected!,
                        );
                      }
                    },
                    child: Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
