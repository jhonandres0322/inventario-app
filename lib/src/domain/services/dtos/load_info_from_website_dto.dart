// To parse this JSON data, do
//
//     final loadInfoFromWebsiteDto = loadInfoFromWebsiteDtoFromJson(jsonString);

import 'dart:convert';

LoadInfoFromWebsiteDto loadInfoFromWebsiteDtoFromJson(String str) =>
    LoadInfoFromWebsiteDto.fromJson(json.decode(str));

String loadInfoFromWebsiteDtoToJson(LoadInfoFromWebsiteDto data) =>
    json.encode(data.toJson());

class LoadInfoFromWebsiteDto {
  final String name;
  final String images;

  LoadInfoFromWebsiteDto({required this.name, required this.images});

  LoadInfoFromWebsiteDto copyWith({String? name, String? images}) =>
      LoadInfoFromWebsiteDto(
        name: name ?? this.name,
        images: images ?? this.images,
      );

  factory LoadInfoFromWebsiteDto.fromJson(Map<String, dynamic> json) =>
      LoadInfoFromWebsiteDto(name: json["name"], images: json["images"]);

  Map<String, dynamic> toJson() => {"name": name, "images": images};
}
