// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  final String? id;
  final String name;
  final String phone;
  final String address;
  final DateTime? createdAt;

  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    this.createdAt,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    String? address,
    DateTime? createdAt,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    createdAt: createdAt ?? this.createdAt,
  );

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "address": address,
  };
}
