class GenreProduct {
  final String label;

  const GenreProduct({required this.label});

  static const List<GenreProduct> all = [
    GenreProduct(label: 'Hombre'),
    GenreProduct(label: 'Mujer'),
    GenreProduct(label: 'Otros'),
  ];

  factory GenreProduct.fromLabel(String label) {
    return all.firstWhere(
      (c) => c.label == label,
      orElse: () => throw Exception('Genero no encontrado'),
    );
  }
}
