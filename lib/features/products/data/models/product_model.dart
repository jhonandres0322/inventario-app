import 'package:inventario_app/features/products/data/codecs/apparel_size_codec.dart';
import 'package:inventario_app/features/products/data/codecs/brand_codec.dart';
import 'package:inventario_app/features/products/domain/entities/product.dart';
import 'package:inventario_app/features/products/domain/vo/brand/brand.dart';
import 'package:inventario_app/features/products/domain/vo/product_category/product_category.dart';

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
  final String categoria;
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
    required this.categoria,
    this.fechaCreacion,
  });

  factory ProductModel.fromEntity(Product e) => ProductModel(
    id: e.id,
    nombre: e.name,
    precioCompra: e.purchasePrice.toString(),
    talla: ApparelSizeCodec.toRaw(e.size),
    cantidad: e.quantity.toString(),
    codigoKliker: e.barcode,
    marca: e.brand.label,
    comision: e.commission.toString(),
    costoReal: e.actualCost.toString(),
    categoria: e.category.label,
    fechaCreacion: DateTime.now(),
    foto1: e.images.first,
    foto2: e.images.last,
  );

  Product toEntity() => Product(
    id: id,
    name: nombre,
    barcode: codigoKliker,
    size: ApparelSizeCodec.parse(talla),
    images: [foto1, foto2],
    purchasePrice: double.parse(precioCompra),
    brand: BrandCodec.parse(marca),
    quantity: int.parse(cantidad),
    category: ProductCategory.values.firstWhere((c) => c.label == categoria),
  );

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
    categoria: json["categoria"] ?? '',
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
      "categoria": categoria,
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

  ProductModel copyWith({
    String? id,
    String? nombre,
    String? precioCompra,
    String? talla,
    String? marca,
    String? comision,
    String? costoReal,
    String? codigoKliker,
    String? cantidad,
    String? categoria,
    String? foto1,
    String? foto2,
    DateTime? fechaCreacion,
  }) {
    return ProductModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      precioCompra: precioCompra ?? this.precioCompra,
      talla: talla ?? this.talla,
      marca: marca ?? this.marca,
      comision: comision ?? this.comision,
      costoReal: costoReal ?? this.costoReal,
      codigoKliker: codigoKliker ?? this.codigoKliker,
      cantidad: cantidad ?? this.cantidad,
      foto1: foto1 ?? this.foto1,
      foto2: foto2 ?? this.foto2,
      categoria: categoria ?? this.categoria,
      fechaCreacion: fechaCreacion ?? this.fechaCreacion,
    );
  }
}
