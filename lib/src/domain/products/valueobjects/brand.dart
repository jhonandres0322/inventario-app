class Brand {
  final String label;

  const Brand({required this.label});

  static const List<Brand> all = [
    Brand(label: 'Americanino'),
    Brand(label: 'Chevignon'),
    Brand(label: 'Polo Atlantic'),
  ];

  factory Brand.fromLabel(String label) {
    return all.firstWhere(
      (b) => b.label == label,
      orElse: () => throw Exception('Marca no encontrada'),
    );
  }
}
