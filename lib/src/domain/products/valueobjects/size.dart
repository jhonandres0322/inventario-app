class SizeProduct {
  final String label;

  const SizeProduct({required this.label});

  static const List<SizeProduct> letterSizes = [
    SizeProduct(label: 'xs'),
    SizeProduct(label: 's'),
    SizeProduct(label: 'm'),
    SizeProduct(label: 'l'),
    SizeProduct(label: 'xl'),
    SizeProduct(label: 'xxl'),
  ];

  static const List<SizeProduct> numericSizes = [
    SizeProduct(label: '28'),
    SizeProduct(label: '30'),
    SizeProduct(label: '32'),
    SizeProduct(label: '34'),
    SizeProduct(label: '36'),
    SizeProduct(label: '38'),
    SizeProduct(label: '40'),
  ];

  static const List<SizeProduct> uniqueSize = [SizeProduct(label: 'unica')];

  factory SizeProduct.fromId(String label) {
    final allSizes = [...letterSizes, ...numericSizes, ...uniqueSize];
    return allSizes.firstWhere(
      (s) => s.label == label,
      orElse: () => throw Exception('Talla no encontrada'),
    );
  }
}
