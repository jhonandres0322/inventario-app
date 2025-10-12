import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/barcode/scan/widgets/barcode_scan_screen.dart';
import 'package:inventario_app/src/ui/core/validations/form_validator.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_dropdown_button_form_field.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_text_form_field.dart';
import 'package:inventario_app/src/ui/core/widgets/snackbar_service.dart';
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
          SnackBarService.showErrorSnackBar(
            context,
            provider.error!,
            provider.resetState,
          );
        }
        if (provider.showSuccess) {
          SnackBarService.showSuccessSnackBar(
            context,
            provider.success!,
            provider.resetState,
          );
        }
        final double spaceBetween = size.height * 0.02;
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
                          validator: (value) => FormValidator.requiredText(
                            value,
                            'código de barras',
                          ),
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
                  GenericDropdownButtonFormField(
                    label: 'Marca',
                    items: provider.brands,
                    validator: (value) =>
                        FormValidator.requiredDropdown(value, 'marca'),
                    onChanged: (value) => provider.brandSelected = value,
                  ),
                  SizedBox(height: spaceBetween),
                  if (provider.isTypedName!) ...[
                    GenericTextFormField(
                      controller: provider.nameController,
                      label: 'Nombre',
                      validator: (value) =>
                          FormValidator.minLengthText(value, 'nombre', 3),
                    ),
                    SizedBox(height: spaceBetween),
                  ],
                  GenericTextFormField(
                    controller: provider.purchasePriceController,
                    label: 'Precio de compra',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        FormValidator.number(value, 'precio de compra'),
                  ),
                  SizedBox(height: spaceBetween),
                  GenericTextFormField(
                    controller: provider.salesPriceController,
                    label: 'Precio de venta',
                    keyboardType: TextInputType.number,
                    validator: (value) => FormValidator.number(
                      value,
                      'precio de venta',
                      allowEmpty: true,
                    ),
                  ),
                  SizedBox(height: spaceBetween),
                  GenericTextFormField(
                    controller: provider.quantityController,
                    keyboardType: TextInputType.number,
                    label: 'Cantidad',
                    validator: (value) =>
                        FormValidator.number(value, 'cantidad'),
                  ),
                  SizedBox(height: spaceBetween),
                  GenericDropdownButtonFormField(
                    label: 'Tipo de Ropa',
                    items: provider.categories,
                    validator: (value) =>
                        FormValidator.requiredDropdown(value, 'tipo de ropa'),
                    onChanged: (value) => provider.categorySelected = value,
                  ),
                  SizedBox(height: spaceBetween),
                  GenericDropdownButtonFormField(
                    label: 'Talla',
                    items: provider.getSizes(),
                    inUpperCaseText: true,
                    onChanged: (value) => provider.sizeSelected = value,
                    validator: (value) =>
                        FormValidator.requiredDropdown(value, 'talla'),
                    value: provider.getSizes().contains(provider.sizeSelected)
                        ? provider.sizeSelected
                        : null,
                  ),
                  SizedBox(height: spaceBetween),
                  GenericDropdownButtonFormField(
                    label: 'Género',
                    items: provider.genres,
                    inUpperCaseText: true,
                    onChanged: (value) => provider.genreSelected = value,
                    validator: (value) =>
                        FormValidator.requiredDropdown(value, 'género'),
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
