import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';
import 'package:inventario_app/src/ui/core/validations/form_validator.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_dropdown_button_form_field.dart';
import 'package:provider/provider.dart';
import 'package:inventario_app/src/ui/products/catalog_products/viewmodels/catalog_products_provider.dart';

class CatalogProductsDrawer extends StatelessWidget {
  const CatalogProductsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CatalogProductsProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final double spaceBetween = 0.04;
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(size.height * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    provider.clearForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors().primary,
                    side: BorderSide(color: AppColors().secondary),
                  ),
                  child: Text(
                    'Limpiar',
                    style: TextStyle(color: AppColors().secondary),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    provider.filterProducts();
                  },
                  child: Text('Filtrar'),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.07),
            Text(
              'Filtrar por',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * spaceBetween),
            GenericDropdownButtonFormField(
              label: 'Marca',
              items: provider.brands,
              onChanged: (value) => provider.brandSelected = value,
              validator: (value) =>
                  FormValidator.requiredDropdown(value, 'marca'),
            ),
            SizedBox(height: size.height * spaceBetween),
            GenericDropdownButtonFormField(
              label: 'Tipo',
              items: provider.categories,
              onChanged: (value) => provider.categorySelected = value,
              validator: (value) =>
                  FormValidator.requiredDropdown(value, 'marca'),
            ),
            SizedBox(height: size.height * spaceBetween),
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
            SizedBox(height: size.height * spaceBetween),
            GenericDropdownButtonFormField(
              label: 'Género',
              items: provider.genres,
              onChanged: (value) => provider.genreSelected = value,
              validator: (value) =>
                  FormValidator.requiredDropdown(value, 'género'),
            ),
          ],
        ),
      ),
    );
  }
}
