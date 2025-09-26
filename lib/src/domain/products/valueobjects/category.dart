import 'size.dart';

class CategoryProduct {
  final String label;
  final List<SizeProduct> allowSizes;

  const CategoryProduct({required this.label, required this.allowSizes});

  static const List<CategoryProduct> all = [
    CategoryProduct(label: 'Camisas', allowSizes: SizeProduct.letterSizes),
    CategoryProduct(label: 'Polos', allowSizes: SizeProduct.letterSizes),
    CategoryProduct(label: 'Vestidos', allowSizes: SizeProduct.letterSizes),
    CategoryProduct(label: 'Camisetas', allowSizes: SizeProduct.letterSizes),
    CategoryProduct(label: 'Jeans', allowSizes: SizeProduct.numericSizes),
    CategoryProduct(label: 'Shorts', allowSizes: SizeProduct.numericSizes),
    CategoryProduct(label: 'Gorras', allowSizes: SizeProduct.uniqueSize),
  ];

  factory CategoryProduct.fromLabel(String label) {
    return all.firstWhere(
      (c) => c.label == label,
      orElse: () => throw Exception('Categoría no encontrada'),
    );
  }
}
