import 'dart:convert';
import 'package:http/http.dart' as http;

class Producto {
  final String id;
  final String nombre;
  final String talla;
  final String marca;
  final int precio;
  final int cantidad;
  final String foto1;
  final String foto2;

  Producto({
    required this.id,
    required this.nombre,
    required this.talla,
    required this.marca,
    required this.precio,
    required this.cantidad,
    required this.foto1,
    required this.foto2,
  });

  factory Producto.fromList(List<dynamic> values) {
    final List<String> stringValues = values.map((e) => e.toString()).toList();

    return Producto(
      id: stringValues[0],
      nombre: stringValues[1],
      talla: stringValues[2],
      marca: stringValues[3],
      precio: int.tryParse(stringValues[4]) ?? 0,
      cantidad: int.tryParse(stringValues[5]) ?? 0,
      foto1: stringValues[6],
      foto2: stringValues[7],
    );
  }
}
