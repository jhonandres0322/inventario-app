import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/widgets/generic_text_form_field.dart';
import 'package:inventario_app/src/ui/customers/save_customer/viewmodels/save_customer_provider.dart';
import 'package:provider/provider.dart';

class SaveCustomerForm extends StatelessWidget {
  SaveCustomerForm({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double spaceBetween = size.height * 0.02;
    return Consumer<SaveCustomerProvider>(
      builder: (context, provider, child) {
        if (provider.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.showError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${provider.error}')));
            provider.resetState();
          });
        }
        if (provider.showSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cliente guardado con éxito')),
            );
            provider.resetState();
          });
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: spaceBetween),
                GenericTextFormField(
                  controller: nameController,
                  label: 'Nombre',
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
                  controller: phoneController,
                  label: 'Celular',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El telefono es obligatorio';
                    }
                    if (value.length != 10) {
                      return 'El telefono debe tener 10 digitos';
                    }
                    return null;
                  },
                ),
                SizedBox(height: spaceBetween),
                GenericTextFormField(
                  controller: addressController,
                  label: 'Dirección',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La dirección es obligatoria';
                    }
                    if (value.length < 3) {
                      return 'La dirección es invalida';
                    }
                    return null;
                  },
                ),
                SizedBox(height: spaceBetween),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      provider.saveCustomer(
                        name: nameController.text,
                        phone: phoneController.text,
                        address: addressController.text,
                      );
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
