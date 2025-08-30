class Size {
  final String id;
  final String label;

  const Size({required this.id, required this.label});

  static const List<Size> letterSizes = [
    Size(id: 'xs', label: 'XS'),
    Size(id: 's', label: 'S'),
    Size(id: 'm', label: 'M'),
    Size(id: 'l', label: 'L'),
    Size(id: 'xl', label: 'XL'),
    Size(id: 'xxl', label: 'xxl'),
  ];

  static const List<Size> numericSizes = [
    Size(id: '28', label: '28'),
    Size(id: '30', label: '30'),
    Size(id: '32', label: '32'),
    Size(id: '34', label: '34'),
    Size(id: '36', label: '36'),
    Size(id: '38', label: '38'),
    Size(id: '40', label: '40'),
  ];

  static const List<Size> uniqueSize = [Size(id: 'unica', label: 'Única')];

  factory Size.fromId(String id) {
    final allSizes = [...letterSizes, ...numericSizes, ...uniqueSize];
    return allSizes.firstWhere(
      (s) => s.id == id,
      orElse: () => throw Exception('Talla no encontrada'),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'label': label};

  factory Size.fromJson(Map<String, dynamic> json) =>
      Size(id: json['id'], label: json['label']);
}
