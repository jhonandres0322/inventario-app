class PageParams {
  final int limit;
  final int offset;

  const PageParams({required this.limit, required this.offset});
}

class Page<T> {
  final List<T> items;
  final bool hasMore;
  final int nextOffset;

  const Page({
    required this.items,
    required this.hasMore,
    required this.nextOffset,
  });
}
