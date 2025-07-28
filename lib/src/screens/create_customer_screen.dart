import 'package:flutter/material.dart';
import 'package:inventario_app/src/widgets/text_form_field_widget.dart';

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
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.05,
          left: size.width * 0.04,
          right: size.width * 0.04,
        ),
        child: Form(
          child: Column(
            children: [
              TextFormFieldWidget(
                hintText: 'Ingrese el nombre del cliente',
                labelText: 'Nombre',
                validator: (value) => null,
              ),
              SizedBox(height: size.height * 0.03),
              TextFormFieldWidget(
                hintText: 'Ingrese el celular',
                labelText: 'Celular',
                validator: (value) => null,
              ),
              SizedBox(height: size.height * 0.03),
              TextFormFieldWidget(
                hintText: 'Ingrese la dirección',
                labelText: 'Dirección',
                validator: (value) => null,
              ),
              SizedBox(height: size.height * 0.08),
              SizedBox(
                width: size.width * 0.9,
                child: ElevatedButton(onPressed: () {}, child: Text('Guardar')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
