enum ProductCategory { shirts, polos, tShirts, jeans, shorts, caps }

extension ProductCategoryLabel on ProductCategory {
  String get label => switch (this) {
    ProductCategory.shirts => 'Camisas',
    ProductCategory.polos => 'Polos',
    ProductCategory.tShirts => 'Camisetas',
    ProductCategory.jeans => 'Jeans',
    ProductCategory.shorts => 'Shorts',
    ProductCategory.caps => 'Gorras',
  };
}
