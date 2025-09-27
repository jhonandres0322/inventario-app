import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/barcode/scan/widgets/barcode_scan_screen.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_dropdown_button_form_field.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_text_form_field.dart';
import 'package:inventario_app/src/ui/products/save_product/viewmodels/save_product_provider.dart';
import 'package:provider/provider.dart';

class SaveProductForm extends StatelessWidget {
  const SaveProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<SaveProductProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.showError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${provider.error}'),
                backgroundColor: AppColors().error,
              ),
            );
            provider.resetState();
          });
        }
        if (provider.showSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Producto guardado con éxito'),
                backgroundColor: AppColors().success,
              ),
            );
            provider.resetState();
          });
        }
        final double spaceBetween = size.height * 0.02;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: provider.formKey,
              child: Column(
                children: [
                  SizedBox(height: spaceBetween),
                  GenericTextFormField(
                    controller: provider.nameController,
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
                    controller: provider.purchasePriceController,
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
                          controller: provider.barcodeController,
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
                                  provider.barcodeController.text = barcode;
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
                    controller: provider.earningsPercentageController,
                    label: 'Porcentaje de Ganancia - Opcional',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      final earnings = double.tryParse(value);
                      if (earnings == null) return 'Debe ser un número válido';
                      if (earnings < 0) {
                        return 'El porcentaje no puede ser negativa';
                      }
                      if (value.startsWith('0') &&
                          !value.startsWith('0.') &&
                          value != '0') {
                        return 'No se permiten ceros a la izquierda';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: spaceBetween),
                  GenericTextFormField(
                    controller: provider.quantityController,
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
                    inUpperCaseText: true,
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
                      if (provider.formKey.currentState!.validate()) {
                        provider.saveProduct();
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
