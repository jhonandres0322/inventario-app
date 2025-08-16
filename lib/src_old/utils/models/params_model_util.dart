import 'dart:convert';

ParamsModelUtil paramsModelUtilFromJson(String str) =>
    ParamsModelUtil.fromJson(json.decode(str));

String paramsModelUtilToJson(ParamsModelUtil data) =>
    json.encode(data.toJson());

class ParamsModelUtil {
  final int? from;
  final int? to;
  final String orderProperty;
  final bool isOrderAscending;
  final bool isFetchAll;

  ParamsModelUtil({
    this.from,
    this.to,
    required this.orderProperty,
    required this.isOrderAscending,
    this.isFetchAll = false,
  });

  factory ParamsModelUtil.fromJson(Map<String, dynamic> json) =>
      ParamsModelUtil(
        from: json["from"],
        to: json["to"],
        orderProperty: json["orderProperty"],
        isOrderAscending: json["isOrderAscending"],
        isFetchAll: json["isFetchAll"],
      );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "orderProperty": orderProperty,
    "isOrderAscending": isOrderAscending,
    "isFetchAll": isFetchAll,
  };
}
