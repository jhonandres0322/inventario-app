import 'package:inventario_app/src/features/products/data/codecs/apparel_size_codec.dart';
import 'package:inventario_app/src/features/products/data/codecs/brand_codec.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/vo/brand/brand.dart';

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
    fechaCreacion: json["fecha_creacion"] != null
        ? DateTime.parse(json["fecha_creacion"])
        : null,
  );
}
