// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final String id;
  final String name;
  final String size;
  final String brand;
  final int purchasePrice;
  final int commission;
  final int actualCost;
  final int quantity;
  final String barcode;
  final String images;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.size,
    required this.brand,
    required this.purchasePrice,
    required this.commission,
    required this.actualCost,
    required this.quantity,
    required this.barcode,
    required this.images,
    required this.createdAt,
  });

  Product copyWith({
    String? id,
    String? name,
    String? size,
    String? brand,
    int? purchasePrice,
    int? commission,
    int? actualCost,
    int? quantity,
    String? barcode,
    String? images,
    DateTime? createdAt,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    size: size ?? this.size,
    brand: brand ?? this.brand,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    commission: commission ?? this.commission,
    actualCost: actualCost ?? this.actualCost,
    quantity: quantity ?? this.quantity,
    barcode: barcode ?? this.barcode,
    images: images ?? this.images,
    createdAt: createdAt ?? this.createdAt,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    size: json["size"],
    brand: json["brand"],
    purchasePrice: json["purchasePrice"],
    commission: json["commission"],
    actualCost: json["actualCost"],
    quantity: json["quantity"],
    barcode: json["barcode"],
    images: json["images"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "size": size,
    "brand": brand,
    "purchasePrice": purchasePrice,
    "commission": commission,
    "actualCost": actualCost,
    "quantity": quantity,
    "barcode": barcode,
    "images": images,
    "createdAt": createdAt.toIso8601String(),
  };
}
