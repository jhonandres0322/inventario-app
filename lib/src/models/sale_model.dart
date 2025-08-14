import 'dart:convert';

SaleModel saleModelFromMap(String str) => SaleModel.fromMap(json.decode(str));

String saleModelToMap(SaleModel data) => json.encode(data.toMap());

enum SaleState {
  paid("Pagado"),
  pending("Pendiente");

  const SaleState(this.value);
  final String value;
}

enum SalePaymentMethod {
  cash("Contado"),
  credit("Credito");

  const SalePaymentMethod(this.value);
  final String value;
}

class SaleModel {
  final String id;
  final String idCliente;
  final String idProducto;
  final String cantidad;
  final String precioUnitario;
  final String total;
  final String estado;
  final String formaPago;
  final bool estaPagado;
  final DateTime? fechaVenta;

  SaleModel({
    this.id = '',
    required this.idCliente,
    required this.idProducto,
    required this.cantidad,
    required this.precioUnitario,
    required this.total,
    required this.estado,
    required this.formaPago,
    required this.estaPagado,
    this.fechaVenta,
  });

  factory SaleModel.fromMap(Map<String, dynamic> json) => SaleModel(
    id: json["id"] ?? '',
    idCliente: json["id_cliente"],
    idProducto: json["id_producto"],
    cantidad: json["cantidad"],
    precioUnitario: json["precio_unitario"],
    total: json["total"],
    estado: json["estado"],
    formaPago: json["forma_pago"],
    estaPagado: json["esta_pagado"],
    fechaVenta: json["fecha_venta"] != null
        ? DateTime.parse(json["fecha_venta"])
        : null,
  );

  Map<String, dynamic> toMap() {
    final map = {
      "idCliente": idCliente,
      "idProducto": idProducto,
      "cantidad": cantidad,
      "precioUnitario": precioUnitario,
      "total": total,
      "estado": estado,
      "formaPago": formaPago,
      "estaPagado": estaPagado,
    };
    if (id.isNotEmpty) {
      map["id"] = id;
    }

    if (fechaVenta != null) {
      map["fecha_venta"] = fechaVenta!.toIso8601String();
    }

    return map;
  }
}
