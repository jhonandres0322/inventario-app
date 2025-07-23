// To parse this JSON data, do
//
//     final customerModel = customerModelFromMap(jsonString);

import 'dart:convert';

CustomerModel customerModelFromMap(String str) =>
    CustomerModel.fromMap(json.decode(str));

String customerModelToMap(CustomerModel data) => json.encode(data.toMap());

class CustomerModel {
  final String id;
  final String nombre;
  final String telefono;
  final String direccion;
  final String fechaRegistro;

  CustomerModel({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.fechaRegistro,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> json) => CustomerModel(
    id: json["id"],
    nombre: json["nombre"],
    telefono: json["telefono"],
    direccion: json["direccion"],
    fechaRegistro: json["fechaRegistro"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "telefono": telefono,
    "direccion": direccion,
    "fechaRegistro": fechaRegistro,
  };
}
