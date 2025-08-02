import 'dart:convert';

CustomerModel customerModelFromMap(String str) =>
    CustomerModel.fromMap(json.decode(str));

String customerModelToMap(CustomerModel data) => json.encode(data.toMap());

class CustomerModel {
  final String id;
  final String nombre;
  final String telefono;
  final String direccion;
  final DateTime? fechaRegistro;

  CustomerModel({
    this.id = '',
    required this.nombre,
    required this.telefono,
    required this.direccion,
    required this.fechaRegistro,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> json) => CustomerModel(
    id: json["id"] ?? '',
    nombre: json["nombre"],
    telefono: json["telefono"],
    direccion: json["direccion"] ?? 'Sin Dirección',
    fechaRegistro: json["fecha_registro"] != null
        ? DateTime.parse(json["fecha_registro"])
        : null,
  );

  Map<String, dynamic> toMap() {
    final map = {
      "nombre": nombre,
      "telefono": telefono,
      "direccion": direccion,
    };
    if (id.isNotEmpty) {
      map["id"] = id;
    }

    if (fechaRegistro != null) {
      map["fecha_registro"] = fechaRegistro!.toIso8601String();
    }
    return map;
  }
}
