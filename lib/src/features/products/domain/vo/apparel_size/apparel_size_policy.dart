import 'package:inventario_app/src/features/products/domain/vo/product_category/product_category.dart';
import 'apparel_size.dart';

class ApparelSizePolicy {
  static bool isAllowed(ProductCategory category, ApparelSize size) {
    return switch (category) {
      ProductCategory.shirts ||
      ProductCategory.polos ||
      ProductCategory.tShirts => size is TopAlphaSize,
      ProductCategory.jeans ||
      ProductCategory.shorts => size is BottomNumericSize,
      ProductCategory.caps => size is OneSize,
    };
  }
}
