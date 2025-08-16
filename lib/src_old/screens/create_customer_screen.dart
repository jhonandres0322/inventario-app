import 'package:flutter/material.dart';
import 'package:inventario_app/src_old/providers/create_customer_provider.dart';
import 'package:inventario_app/src_old/widgets/snackbar_custom_widget.dart';
import 'package:inventario_app/src_old/widgets/text_form_field_widget.dart';
import 'package:provider/provider.dart';

class CreateCustomerScreen extends StatelessWidget {
  const CreateCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Crear Cliente')),
        body: Stack(children: [_MainFormCreateCustomer()]),
      ),
    );
  }
}

class _MainFormCreateCustomer extends StatelessWidget {
  const _MainFormCreateCustomer();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CreateCustomerProvider provider = Provider.of<CreateCustomerProvider>(
      context,
    );
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          provider.clearAll();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: size.height * 0.05,
            left: size.width * 0.04,
            right: size.width * 0.04,
          ),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  hintText: 'Ingrese el nombre del cliente',
                  labelText: 'Nombre',
                  validator: (value) => provider.validateName(value),
                  onChanged: (value) => provider.name = value,
                  value: provider.name,
                ),
                SizedBox(height: size.height * 0.03),
                TextFormFieldWidget(
                  hintText: 'Ingrese el celular',
                  labelText: 'Celular',
                  validator: (value) => provider.validatePhone(value),
                  onChanged: (value) => provider.phone = value,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                ),
                SizedBox(height: size.height * 0.03),
                TextFormFieldWidget(
                  hintText: 'Ingrese la dirección',
                  labelText: 'Dirección',
                  validator: (value) => null,
                  onChanged: (value) => provider.address = value,
                ),
                SizedBox(height: size.height * 0.08),
                SizedBox(
                  width: size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: !provider.disabledButtonSaveForm()
                        ? () async {
                            bool response = await provider.onSubmitForm();
                            String message = response
                                ? 'Cliente creado!'
                                : 'Error al crear el cliente';
                            SnackbarCustomWidget.show(
                              context,
                              message: message,
                              type: response
                                  ? SnackbarType.success
                                  : SnackbarType.error,
                            );
                            Navigator.pop(context);
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
