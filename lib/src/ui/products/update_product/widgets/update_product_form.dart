import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/barcode/scan/widgets/barcode_scan_screen.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_dropdown_button_form_field.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_text_form_field.dart';
import 'package:inventario_app/src/ui/products/update_product/viewmodels/update_product_provider.dart';
import 'package:provider/provider.dart';

class UpdateProductForm extends StatelessWidget {
  const UpdateProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<UpdateProductProvider>(
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
                content: Text(provider.success!),
                backgroundColor: AppColors().success,
              ),
            );
            provider.resetState();
          });
        }
        final double spaceBetween = size.height * 0.02;
        if (provider.productSelected != null) {
          provider.quantityController.text = provider.productSelected!.quantity
              .toString();
          provider.nameController.text = provider.productSelected!.name;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: provider.formKey,
              child: Column(
                children: [
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
                  ElevatedButton(
                    onPressed: () {
                      provider.searchProductByBarcode();
                    },
                    child: Text('Buscar Producto'),
                  ),
                  SizedBox(height: spaceBetween),
                  if (provider.sizes.isNotEmpty) ...[
                    GenericDropdownButtonFormField(
                      label: 'Talla',
                      inUpperCaseText: true,
                      items: provider.sizes,
                      onChanged: (value) => provider.sizeSelected = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La talla es requerida';
                        }
                        return null;
                      },
                      value: provider.sizes.contains(provider.sizeSelected)
                          ? provider.sizeSelected
                          : null,
                    ),
                  ],

                  if (provider.productSelected != null) ...[
                    SizedBox(height: spaceBetween),
                    GenericTextFormField(
                      controller: provider.nameController,
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      label: 'Nombre',
                      validator: (value) => null,
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
                        if (price < 0) {
                          return 'La cantidad no puede ser negativa';
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
                    ElevatedButton(
                      onPressed: () {
                        if (provider.formKey.currentState!.validate()) {
                          provider.updateProduct();
                        }
                      },
                      child: Text('Actualizar'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
