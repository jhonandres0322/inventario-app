import 'package:inventario_app/src_old/core/domain/app_sizes_clothes.dart';

class TypeClothes {
  String key;
  String name;
  List<String> sizes;

  TypeClothes({required this.key, required this.name, required this.sizes});
}

class AppTypeClothes {
  List<TypeClothes> get typeClothes {
    return [
      TypeClothes(
        key: 'polos',
        name: 'Polos',
        sizes: AppSizesClothes().sizesText,
      ),
      TypeClothes(
        key: 'camisetas',
        name: 'Camisetas',
        sizes: AppSizesClothes().sizesText,
      ),
      TypeClothes(
        key: 'jeans',
        name: 'Jeans',
        sizes: AppSizesClothes().sizesNumber,
      ),
      TypeClothes(
        key: 'bermudas',
        name: 'Bermudas',
        sizes: AppSizesClothes().sizesNumber,
      ),
      TypeClothes(
        key: 'gorras',
        name: 'Gorras',
        sizes: AppSizesClothes().sizesUnique,
      ),
    ];
  }
}
