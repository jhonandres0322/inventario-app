import 'dart:convert';

ProductModel productFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
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

  ProductModel({
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

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
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

  ProductModel copyWith({String? precioCompra, String? cantidad}) {
    return ProductModel(
      id: id,
      nombre: nombre,
      talla: talla,
      marca: marca,
      precioCompra: precioCompra ?? this.precioCompra,
      cantidad: cantidad ?? this.cantidad,
      foto1: foto1,
      foto2: foto2,
      codigoKliker: codigoKliker,
      comision: comision,
      costoReal: costoReal,
      fechaCreacion: fechaCreacion,
    );
  }

  void calculateCommision() {
    final double priceDouble = double.parse(precioCompra);
    final double comissionDouble = priceDouble * 0.25;
    comision = comissionDouble.toString();
  }

  void calculateRealCost() {
    final double priceDouble = double.parse(precioCompra);
    final double realCostDouble = priceDouble - double.parse(comision);
    costoReal = realCostDouble.toString();
  }
}
