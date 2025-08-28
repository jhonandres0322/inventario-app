import 'package:flutter/material.dart';
import 'package:inventario_app/src/features/products/domain/vo/apparel_size/apparel_size.dart';
import 'package:inventario_app/src/features/products/domain/vo/brand/brand.dart';
import 'package:inventario_app/src/features/products/domain/vo/product_category/product_category.dart';
import 'package:inventario_app/src/features/products/presentation/providers/save_product_provider.dart';
import 'package:inventario_app/src/shared/presentation/widgets/generic_dropdown_button_form_field.dart';
import 'package:inventario_app/src/shared/presentation/widgets/generic_text_form_field.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductFormWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selectedBrand;
  String? selectedSize;

  ProductFormWidget({super.key});

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
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                GenericTextFormField(
                  controller: nameController,
                  hintText: 'Ingrese la referencia del producto',
                  label: 'Nombre o referencia',
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
                SizedBox(height: size.height * 0.02),
                GenericTextFormField(
                  controller: purchasePriceController,
                  hintText: 'Ingrese el precio de compra',
                  label: 'Precio de Compra',
                  validator: (value) => null,
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GenericTextFormField(
                        controller: barcodeController,
                        hintText: '',
                        label: 'Código de barras',
                        validator: (value) => null,
                        readOnly: true,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.barcode_reader),
                      iconSize: size.height * 0.05,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                GenericTextFormField(
                  controller: quantityController,
                  hintText: 'Ingrese la cantidad',
                  label: 'Cantidad',
                  validator: (value) => null,
                ),
                SizedBox(height: size.height * 0.03),
                GenericDropdownButtonFormField<ProductCategory>(
                  hintText: 'Escoja el tipo de prenda',
                  labelText: 'Tipo de prenda',
                  items: provider.getCategories(),
                  itemBuilder: (category) => Text(category.label),
                  onChanged: (value) => provider.setSelectedCategory(value),
                ),
                SizedBox(height: size.height * 0.03),
                GenericDropdownButtonFormField<ApparelSize>(
                  hintText: provider.selectedCategory == null
                      ? 'Seleccione una categoría primero'
                      : 'Escoja la talla',
                  labelText: 'Talla',
                  value: provider.selectedSize,
                  items: provider.getSizes(),
                  onChanged: provider.setSelectedSize,
                  itemBuilder: (size) => Text(size.label),
                  validator: (value) =>
                      value == null ? 'La talla es obligatoria' : null,
                  decoration: InputDecoration(
                    labelText: 'Talla',
                    hintText: provider.selectedCategory == null
                        ? 'Seleccione una categoría primero'
                        : 'Escoja la talla',
                    enabled:
                        provider.selectedCategory !=
                        null, // Deshabilita si no hay categoría
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                GenericDropdownButtonFormField<Brand>(
                  hintText: 'Seleccione la marca',
                  labelText: 'Marca',
                  items: provider.getBrands(),
                  itemBuilder: (category) => Text(category.label),
                  onChanged: (value) => provider.setSelectedBrand(value),
                ),
                Expanded(child: SizedBox(height: size.height * 0.05)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(size.width * 0.9),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // final product = Product(
                      //   id: '',
                      //   name: nameController.text,
                      //   size: ApparelSizeCatalog.bottomNumeric.first,
                      //   brand: Brand.adidas,
                      //   purchasePrice: 0,
                      //   quantity: 0,
                      //   barcode: '',
                      //   images: [],
                      // );
                      // provider.saveProduct(product);
                    }
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
