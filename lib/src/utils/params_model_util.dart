import 'dart:convert';

ParamsModelUtil paramsModelUtilFromJson(String str) =>
    ParamsModelUtil.fromJson(json.decode(str));

String paramsModelUtilToJson(ParamsModelUtil data) =>
    json.encode(data.toJson());

class ParamsModelUtil {
  final int from;
  final int to;
  final String orderProperty;
  final bool isOrderAscending;

  ParamsModelUtil({
    required this.from,
    required this.to,
    required this.orderProperty,
    required this.isOrderAscending,
  });

  factory ParamsModelUtil.fromJson(Map<String, dynamic> json) =>
      ParamsModelUtil(
        from: json["from"],
        to: json["to"],
        orderProperty: json["orderProperty"],
        isOrderAscending: json["isOrderAscending"],
      );

  Map<String, dynamic> toJson() => {
    "from": from,
    "to": to,
    "orderProperty": orderProperty,
    "isOrderAscending": isOrderAscending,
  };
}
