import 'package:flutter/material.dart';

class DetailProductModalDelete extends StatelessWidget {
  const DetailProductModalDelete({super.key});

  final String titulo = '¿Estás seguro?';
  final String mensaje = '¿Deseas eliminar el producto?';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ElevatedButton(
          child: const Text('Aceptar'),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
