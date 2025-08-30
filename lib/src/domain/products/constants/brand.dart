class Brand {
  final String id;
  final String label;

  const Brand({required this.id, required this.label});

  static const List<Brand> all = [
    Brand(id: 'americanino', label: 'Americanino'),
    Brand(id: 'chevignon', label: 'Chevignon'),
    Brand(id: 'polo-atlantic', label: 'Polo Atlantic'),
  ];

  factory Brand.fromId(String id) {
    return all.firstWhere(
      (b) => b.id == id,
      orElse: () => throw Exception('Marca no encontrada'),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'label': label};
  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(id: json['id'], label: json['label']);
}
