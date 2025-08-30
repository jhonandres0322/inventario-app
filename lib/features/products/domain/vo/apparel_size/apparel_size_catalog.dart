// domain/apparel_size_catalog.dart
import 'package:inventario_app/features/products/domain/vo/apparel_size/apparel_size.dart';
import 'package:inventario_app/features/products/domain/vo/product_category/product_category.dart';

class ApparelSizeCatalog {
  static const List<TopAlphaSize> topAlpha = [
    TopAlphaSize(TopAlphaCode.xs),
    TopAlphaSize(TopAlphaCode.s),
    TopAlphaSize(TopAlphaCode.m),
    TopAlphaSize(TopAlphaCode.l),
    TopAlphaSize(TopAlphaCode.xl),
    TopAlphaSize(TopAlphaCode.xxl),
  ];

  static const List<BottomNumericSize> bottomNumeric = [
    BottomNumericSize(28),
    BottomNumericSize(30),
    BottomNumericSize(32),
    BottomNumericSize(34),
    BottomNumericSize(36),
    BottomNumericSize(38),
    BottomNumericSize(40),
  ];

  static const OneSize oneSize = OneSize();

  static List<ApparelSize> getSizesByCategory(ProductCategory category) {
    return switch (category) {
      ProductCategory.shirts ||
      ProductCategory.polos ||
      ProductCategory.tShirts => List<ApparelSize>.from(topAlpha),
      ProductCategory.jeans ||
      ProductCategory.shorts => List<ApparelSize>.from(bottomNumeric),
      ProductCategory.caps => [oneSize],
    };
  }
}
