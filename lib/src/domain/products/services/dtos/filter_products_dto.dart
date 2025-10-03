// To parse this JSON data, do
//
//     final filterProductsDto = filterProductsDtoFromJson(jsonString);

import 'dart:convert';

FilterProductsDto filterProductsDtoFromJson(String str) =>
    FilterProductsDto.fromJson(json.decode(str));

String filterProductsDtoToJson(FilterProductsDto data) =>
    json.encode(data.toJson());

class FilterProductsDto {
  final String? brand;
  final String? type;
  final String? size;
  final String? genre;

  FilterProductsDto({this.brand, this.type, this.size, this.genre});

  FilterProductsDto copyWith({
    String? brand,
    String? type,
    String? size,
    String? genre,
  }) => FilterProductsDto(
    brand: brand ?? this.brand,
    type: type ?? this.type,
    size: size ?? this.size,
    genre: genre ?? this.genre,
  );

  factory FilterProductsDto.fromJson(Map<String, dynamic> json) =>
      FilterProductsDto(
        brand: json["brand"],
        type: json["type"],
        size: json["size"],
        genre: json["genre"],
      );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "type": type,
    "size": size,
    "genre": genre,
  };
}
