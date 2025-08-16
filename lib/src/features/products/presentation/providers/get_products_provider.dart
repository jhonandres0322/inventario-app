import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/paging.dart';
import 'package:inventario_app/src/features/products/domain/entities/product.dart';
import 'package:inventario_app/src/features/products/domain/usecases/get_products_page.dart';
import '../../../../di/injection.dart';

class GetProductsProvider extends ChangeNotifier {
  final _getPage = sl<GetProductsPageUseCase>();

  final int _pageSize = 8;
  final ScrollController scrollController = ScrollController();

  List<Product> _items = [];
  bool _loading = false;
  bool _loadingMore = false;
  String? _error;
  bool _hasMore = true;
  int _offset = 0;

  List<Product> get items => _items;
  bool get loading => _loading;
  bool get loadingMore => _loadingMore;
  String? get error => _error;
  bool get hasMore => _hasMore;

  GetProductsProvider() {
    scrollController.addListener(() {
      double posPixeles = scrollController.position.pixels;
      double posMaxScrollExtent = scrollController.position.maxScrollExtent;
      if (posPixeles >= posMaxScrollExtent) {
        loadMore();
      }
    });
  }

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    _offset = 0;
    _hasMore = true;
    _items = [];

    final res = await _getPage(PageParams(limit: _pageSize, offset: _offset));
    res.when(
      ok: (page) {
        _items = page.items;
        _hasMore = page.hasMore;
        _offset = page.nextOffset;
      },
      err: (m) {
        _error = m;
      },
    );
    _loading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_loading || _loadingMore || !_hasMore) return;
    _loadingMore = true;
    notifyListeners();

    final res = await _getPage(PageParams(limit: _pageSize, offset: _offset));
    res.when(
      ok: (page) {
        _items = [..._items, ...page.items];
        _hasMore = page.hasMore;
        _offset = page.nextOffset;
      },
      err: (m) {
        _error = m;
      },
    );

    _loadingMore = false;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
