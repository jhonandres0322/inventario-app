import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/barcode/scan/widgets/barcode_scan_screen.dart';
import 'package:inventario_app/src/ui/core/validations/form_validator.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_dropdown_button_form_field.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_text_form_field.dart';
import 'package:inventario_app/src/ui/core/widgets/snackbar_service.dart';
import 'package:inventario_app/src/ui/products/save_product/viewmodels/save_product_provider.dart';
import 'package:inventario_app/src/ui/products/save_product/widgets/save_product_image_picker.dart';
import 'package:provider/provider.dart';

class SaveProductForm extends StatelessWidget {
  const SaveProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SaveProductProvider>(
      builder: (context, provider, _) {
        _handleProviderMessages(context, provider);

        if (provider.stateCurrent ==
            StatesSaveProductScreen.createdIncomplete) {
          return _buildIncompleteForm(context, provider);
        }

        return _buildMainForm(context, provider);
      },
    );
  }

  void _handleProviderMessages(
    BuildContext context,
    SaveProductProvider provider,
  ) {
    if (provider.isLoading) {
      return;
    }

    if (provider.isError) {
      SnackBarService.showErrorSnackBar(
        context,
        provider.messageError!,
        provider.resetState,
      );
    }

    if (provider.isSuccess) {
      SnackBarService.showSuccessSnackBar(
        context,
        provider.messageSuccess!,
        provider.resetState,
      );
    }
  }

  Widget _buildIncompleteForm(
    BuildContext context,
    SaveProductProvider provider,
  ) {
    final size = MediaQuery.of(context).size;
    final space = size.height * 0.02;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GenericTextFormField(
                    controller: provider.nameController,
                    label: 'Nombre',
                    validator: (value) =>
                        FormValidator.requiredText(value, 'nombre'),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    SaveProductImagePicker.showModal(context);
                  },
                  icon: const Icon(Icons.camera_alt),
                  iconSize: size.height * 0.05,
                ),
              ],
            ),
            _spaceBetween(space),
            if (provider.selectedImage != null) ...[
              Card(
                elevation: 6,
                // ignore: deprecated_member_use
                shadowColor: Colors.black.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.file(provider.selectedImage!, fit: BoxFit.cover),
              ),
            ] else ...[
              Text('Imagen no seleccionada'),
            ],
            _spaceBetween(space),
            ElevatedButton(
              onPressed: () {
                provider.updateProductIncomplete();
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainForm(BuildContext context, SaveProductProvider provider) {
    final size = MediaQuery.of(context).size;
    final space = size.height * 0.02;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: provider.formKey,
        child: Column(
          children: [
            _buildBarcodeField(context, provider, size, space),
            _spaceBetween(space),
            _dropdown(
              label: 'Marca',
              items: provider.brands,
              onChanged: (v) => provider.brandSelected = v,
              validator: (v) => FormValidator.requiredDropdown(v, 'marca'),
            ),
            _spaceBetween(space),
            _numberField(
              controller: provider.purchasePriceController,
              label: 'Precio de compra',
              validator: (v) => FormValidator.number(v, 'precio de compra'),
            ),
            _spaceBetween(space),
            _numberField(
              controller: provider.salesPriceController,
              label: 'Precio de venta',
              validator: (v) =>
                  FormValidator.number(v, 'precio de venta', allowEmpty: true),
            ),

            _spaceBetween(space),
            _numberField(
              controller: provider.quantityController,
              label: 'Cantidad',
              validator: (v) => FormValidator.number(v, 'cantidad'),
            ),

            _spaceBetween(space),
            _dropdown(
              label: 'Tipo de Ropa',
              items: provider.categories,
              validator: (v) =>
                  FormValidator.requiredDropdown(v, 'tipo de ropa'),
              onChanged: (v) => provider.categorySelected = v,
            ),

            _spaceBetween(space),
            _dropdown(
              label: 'Talla',
              items: provider.getSizes(),
              inUpperCaseText: true,
              value: provider.getSizes().contains(provider.sizeSelected)
                  ? provider.sizeSelected
                  : null,
              validator: (v) => FormValidator.requiredDropdown(v, 'talla'),
              onChanged: (v) => provider.sizeSelected = v,
            ),

            _spaceBetween(space),
            _dropdown(
              label: 'Género',
              items: provider.genres,
              inUpperCaseText: true,
              validator: (v) => FormValidator.requiredDropdown(v, 'género'),
              onChanged: (v) => provider.genreSelected = v,
            ),

            _spaceBetween(space),
            ElevatedButton(
              onPressed: () {
                if (provider.formKey.currentState!.validate()) {
                  provider.saveProduct();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeField(
    BuildContext context,
    SaveProductProvider provider,
    Size size,
    double space,
  ) {
    return Row(
      children: [
        Expanded(
          child: GenericTextFormField(
            controller: provider.barcodeController,
            label: 'Código de barras',
            readOnly: true,
            validator: (value) =>
                FormValidator.requiredText(value, 'código de barras'),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BarcodeScanScreen(
                  onBarcodeScanned: (barcode) {
                    provider.barcodeController.text = barcode;
                  },
                ),
              ),
            );
          },
          icon: const Icon(Icons.barcode_reader),
          iconSize: size.height * 0.05,
        ),
      ],
    );
  }

  Widget _dropdown({
    required String label,
    required List<String> items,
    required Function(String?) onChanged,
    String? value,
    bool inUpperCaseText = false,
    String? Function(String?)? validator,
  }) {
    return GenericDropdownButtonFormField(
      label: label,
      items: items,
      value: value,
      validator: validator,
      inUpperCaseText: inUpperCaseText,
      onChanged: onChanged,
    );
  }

  Widget _numberField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return GenericTextFormField(
      controller: controller,
      label: label,
      keyboardType: TextInputType.number,
      validator: validator,
    );
  }

  Widget _spaceBetween(double space) => SizedBox(height: space);
}
