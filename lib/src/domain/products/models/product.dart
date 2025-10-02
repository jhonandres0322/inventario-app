// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final String? id;
  final String name;
  final String size;
  final String brand;
  final int purchasePrice;
  final int? earningsPercentage;
  int? salesPrice;
  final int quantity;
  final String barcode;
  final String type;
  final String genre;
  String? images;
  final DateTime? createdAt;

  Product({
    this.id,
    required this.name,
    required this.size,
    required this.brand,
    required this.purchasePrice,
    required this.earningsPercentage,
    required this.quantity,
    required this.barcode,
    required this.type,
    required this.genre,
    this.images,
    this.createdAt,
  }) {
    salesPrice = calculatedSalesPrice;
  }

  int get calculatedSalesPrice {
    if (earningsPercentage == null) return purchasePrice; // O lanza error/usa 0
    return (purchasePrice * (1 + (earningsPercentage! / 100))).round();
  }

  Product copyWith({
    String? id,
    String? name,
    String? size,
    String? brand,
    int? purchasePrice,
    int? earningsPercentage,
    int? salesPrice,
    int? quantity,
    String? barcode,
    String? type,
    String? genre,
    String? images,
    DateTime? createdAt,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    size: size ?? this.size,
    brand: brand ?? this.brand,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    earningsPercentage: earningsPercentage ?? this.earningsPercentage,
    quantity: quantity ?? this.quantity,
    barcode: barcode ?? this.barcode,
    type: type ?? this.type,
    genre: genre ?? this.genre,
    images: images ?? this.images,
    createdAt: createdAt ?? this.createdAt,
  );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    size: json["size"],
    brand: json["brand"],
    purchasePrice: json["purchasePrice"],
    earningsPercentage: json["earningsPercentage"],
    quantity: json["quantity"],
    barcode: json["barcode"],
    type: json["type"],
    genre: json["genre"],
    images: json["images"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() {
    final map = {
      "name": name,
      "size": size,
      "brand": brand,
      "purchasePrice": purchasePrice,
      "earningsPercentage": earningsPercentage,
      "salesPrice": salesPrice,
      "quantity": quantity,
      "barcode": barcode,
      "genre": genre,
      "type": type,
      "images": images,
    };
    if (id != null) {
      map["id"] = id;
    }

    if (createdAt != null) {
      map["createdAt"] = createdAt!.toIso8601String();
    }

    return map;
  }
}
