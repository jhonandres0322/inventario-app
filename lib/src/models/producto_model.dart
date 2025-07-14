import 'dart:convert';

Product productFromMap(String str) => Product.fromMap(json.decode(str));

String productToMap(Product data) => json.encode(data.toMap());

class Product {
  final String id;
  final String nombre;
  final String precioCompra;
  final String talla;
  final String marca;
  String comision;
  String costoReal;
  final String codigoKliker;
  final String cantidad;
  String foto1;
  String foto2;
  final DateTime? fechaCreacion;

  Product({
    this.id = '',
    required this.nombre,
    required this.precioCompra,
    required this.talla,
    required this.marca,
    this.comision = "0",
    this.costoReal = "0",
    required this.codigoKliker,
    required this.cantidad,
    this.foto1 = "",
    this.foto2 = "",
    this.fechaCreacion,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["id"] ?? '',
    nombre: json["nombre"],
    precioCompra: json["precio_compra"],
    talla: json["talla"],
    marca: json["marca"],
    comision: json["comision"] ?? '0',
    costoReal: json["costo_real"] ?? '0',
    codigoKliker: json["codigo_kliker"],
    cantidad: json["cantidad"],
    foto1: json["foto_1"] ?? '',
    foto2: json["foto_2"] ?? '',
    fechaCreacion: json["fecha_creacion"] != null
        ? DateTime.parse(json["fecha_creacion"])
        : null,
  );

  Map<String, dynamic> toMap() {
    final map = {
      "nombre": nombre,
      "precio_compra": precioCompra,
      "talla": talla,
      "marca": marca,
      "comision": comision,
      "costo_real": costoReal,
      "codigo_kliker": codigoKliker,
      "cantidad": cantidad,
      "foto_1": foto1,
      "foto_2": foto2,
    };
    if (id.isNotEmpty) {
      map["id"] = id;
    }

    if (fechaCreacion != null) {
      map["fecha_creacion"] = fechaCreacion!.toIso8601String();
    }
    return map;
  }

  void calcularComision() {
    final double priceDouble = double.parse(precioCompra);
    final double comissionDouble = priceDouble * 0.25;
    setComision(comissionDouble.toString());
  }

  void calcularCostoReal() {
    final double priceDouble = double.parse(precioCompra);
    final double realCostDouble = priceDouble - double.parse(comision);
    setCostoReal(realCostDouble.toString());
  }

  void setComision(String value) {
    comision = value;
  }

  void setCostoReal(String value) {
    costoReal = value;
  }
}
