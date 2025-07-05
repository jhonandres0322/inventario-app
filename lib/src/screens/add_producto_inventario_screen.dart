import 'package:flutter/material.dart';

class AddProductoInventarioScreen extends StatelessWidget {
  const AddProductoInventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Producto'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
