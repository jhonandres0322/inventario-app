import 'package:inventario_app/src/features/products/domain/vo/apparel_size/apparel_size.dart';
import 'package:inventario_app/src/features/products/domain/vo/brand/brand.dart';
import 'package:inventario_app/src/features/products/domain/vo/product_category/product_category.dart';

double _round2(num v) => (v * 100).roundToDouble() / 100.0;

class Product {
  final String id;
  final String name;
  final ApparelSize size;
  final Brand brand;
  final double purchasePrice;
  final double commission;
  final double actualCost;
  final int quantity;
  final String barcode;
  final List<String> images;
  final ProductCategory category;

  const Product._({
    required this.id,
    required this.name,
    required this.size,
    required this.brand,
    required this.purchasePrice,
    required this.commission,
    required this.actualCost,
    required this.quantity,
    required this.barcode,
    required this.images,
    required this.category,
  });

  factory Product({
    required String id,
    required String name,
    required ApparelSize size,
    required Brand brand,
    required double purchasePrice,
    required int quantity,
    required String barcode,
    required List<String> images,
    required ProductCategory category,
  }) {
    final commission = _round2(purchasePrice * 0.25);
    final actual = _round2(purchasePrice - commission);
    return Product._(
      id: id,
      name: name,
      size: size,
      brand: brand,
      purchasePrice: purchasePrice,
      commission: commission,
      actualCost: actual,
      quantity: quantity,
      barcode: barcode,
      images: images,
      category: category,
    );
  }

  Product copyWith({
    String? name,
    ApparelSize? size,
    Brand? brand,
    double? purchasePrice,
    int? quantity,
    String? barcode,
    List<String>? images,
    ProductCategory? category,
  }) {
    final commission = _round2(purchasePrice! * 0.25);
    final actual = _round2(purchasePrice - commission);

    return Product._(
      id: id,
      name: name ?? this.name,
      size: size ?? this.size,
      brand: brand ?? this.brand,
      purchasePrice: purchasePrice,
      commission: commission,
      actualCost: actual,
      quantity: quantity ?? this.quantity,
      barcode: barcode ?? this.barcode,
      images: images ?? this.images,
      category: category ?? this.category,
    );
  }
}
