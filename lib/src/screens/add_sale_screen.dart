import 'package:flutter/material.dart';
import 'package:inventario_app/src/providers/add_sale_provider.dart';
import 'package:inventario_app/src/widgets/snackbar_custom_widget.dart';
import 'package:inventario_app/src/widgets/text_form_field_widget.dart';
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
  const _MainFormAddSale();

  @override
  Widget build(BuildContext context) {
    final AddSaleProvider provider = Provider.of<AddSaleProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return provider.isLoading &&
            provider.customers.isEmpty &&
            provider.products.isEmpty
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () => provider.loadAll(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                child: Form(
                  key: provider.formKey,
                  child: SizedBox(
                    width: size.width * 0.9,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.03),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Producto',
                            hintText: 'Selecciona el producto',
                          ),
                          items: provider.products.map((product) {
                            return DropdownMenuItem(
                              value: product.id,
                              child: Text(product.nombre),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              provider.productSelected = value ?? '',
                          validator: (value) => provider.validateEmpty(value),
                        ),
                        SizedBox(height: size.height * 0.03),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Clientes',
                            hintText: 'Selecciona el cliente',
                          ),
                          items: provider.customers.map((customer) {
                            return DropdownMenuItem(
                              value: customer.id,
                              child: Text(customer.nombre),
                            );
                          }).toList(),
                          validator: (value) => provider.validateEmpty(value),
                          onChanged: (value) =>
                              provider.customerSelected = value ?? '',
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFormFieldWidget(
                          hintText: 'Ingrese la cantidad vendida',
                          labelText: 'Cantidad Vendida',
                          validator: (value) =>
                              provider.validateNumberForm(value),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => provider.quantity = value,
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFormFieldWidget(
                          hintText: 'Ingrese el precio unitario',
                          labelText: 'Precio Unitario',
                          validator: (value) =>
                              provider.validateNumberForm(value),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => provider.priceUnit = value,
                        ),
                        SizedBox(height: size.height * 0.03),
                        TextFormFieldWidget(
                          hintText: '',
                          labelText: 'Precio Total',
                          validator: (value) => null,
                          readOnly: true,
                          controller: provider.priceTotalController,
                        ),
                        SizedBox(height: size.height * 0.03),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Forma de pago',
                            hintText: 'Selecciona la forma de pago',
                          ),
                          validator: (value) => provider.validateEmpty(value),
                          items: provider.paymentTypes.map((payment) {
                            return DropdownMenuItem(
                              value: payment,
                              child: Text(payment),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              provider.paymentTypeSelected = value ?? '',
                        ),
                        SizedBox(height: size.height * 0.05),
                        SizedBox(
                          width: size.width * 0.9,
                          child: ElevatedButton(
                            onPressed: !provider.disabledButtonSaveForm()
                                ? () async {
                                    bool response = await provider
                                        .onSubmitForm();
                                    String message = response
                                        ? 'Venta creada!'
                                        : 'Error al guardar la venta';
                                    SnackbarCustomWidget.show(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      message: message,
                                      type: response
                                          ? SnackbarType.success
                                          : SnackbarType.error,
                                    );
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: Text('Guardar Venta'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
