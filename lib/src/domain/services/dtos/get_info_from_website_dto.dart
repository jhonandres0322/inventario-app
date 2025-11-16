// To parse this JSON data, do
//
//     final GetInfoFromWebsiteDto = loadInfoFromWebsiteDtoFromJson(jsonString);

import 'dart:convert';

GetInfoFromWebsiteDto getInfoFromWebsiteDtoFromJson(String str) =>
    GetInfoFromWebsiteDto.fromJson(json.decode(str));

String getInfoFromWebsiteDtoToJson(GetInfoFromWebsiteDto data) =>
    json.encode(data.toJson());

class GetInfoFromWebsiteDto {
  final String name;
  final String images;
  final bool isSuccess;

  GetInfoFromWebsiteDto({
    required this.name,
    required this.images,
    required this.isSuccess,
  });

  GetInfoFromWebsiteDto copyWith({
    String? name,
    String? images,
    bool? isSuccess,
  }) => GetInfoFromWebsiteDto(
    name: name ?? this.name,
    images: images ?? this.images,
    isSuccess: isSuccess ?? this.isSuccess,
  );

  factory GetInfoFromWebsiteDto.fromJson(Map<String, dynamic> json) =>
      GetInfoFromWebsiteDto(
        name: json["name"],
        images: json["images"],
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "images": images,
    "isSuccess": isSuccess,
  };
}
