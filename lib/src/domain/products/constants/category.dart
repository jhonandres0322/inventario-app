import 'size.dart';

class Category {
  final String id;
  final String label;
  final List<Size> allowSizes;

  const Category({
    required this.id,
    required this.label,
    required this.allowSizes,
  });

  static const List<Category> all = [
    Category(id: 'camisas', label: 'Camisas', allowSizes: Size.letterSizes),
    Category(id: 'polos', label: 'Polos', allowSizes: Size.letterSizes),
    Category(id: 'vestidos', label: 'Vestidos', allowSizes: Size.letterSizes),
    Category(id: 'camisetas', label: 'Camisetas', allowSizes: Size.letterSizes),
    Category(id: 'jeans', label: 'Jeans', allowSizes: Size.numericSizes),
    Category(id: 'shorts', label: 'Shorts', allowSizes: Size.numericSizes),
    Category(id: 'gorras', label: 'Gorras', allowSizes: Size.uniqueSize),
  ];

  factory Category.fromId(String id) {
    return all.firstWhere(
      (c) => c.id == id,
      orElse: () => throw Exception('Categoría no encontrada'),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'label': label};
  factory Category.fromJson(Map<String, dynamic> json) =>
      Category.fromId(json['id']);
}
