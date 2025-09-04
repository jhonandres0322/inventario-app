import 'dart:async';
import 'package:flutter/material.dart';

import 'package:inventario_app/src/config/pagination/paging.dart';
import 'package:inventario_app/src/data/products/repositories/products_repository.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/ui/core/viewmodels/search_mixin.dart';

import '../../../../config/di/injection.dart';

class GetProductsProvider extends ChangeNotifier with SearchMixin<Product> {
  Timer? _debounce;
  final _repository = sl<ProductsRepository>();

  final int _pageSize = 8;
  final ScrollController scrollController = ScrollController();

  bool _loading = false;
  bool _loadingMore = false;
  String? _error;
  bool _hasMore = true;
  int _offset = 0;

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
    items = [];
    filteredItems = [];
  }

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    _offset = 0;
    _hasMore = true;
    items = [];
    filteredItems = [];

    final res = await _repository.getPage(
      PageParams(limit: _pageSize, offset: _offset),
    );
    res.when(
      ok: (page) {
        items = page.items;
        filteredItems = List.from(items);
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

    final res = await _repository.getPage(
      PageParams(limit: _pageSize, offset: _offset),
    );
    res.when(
      ok: (page) {
        items = [...items, ...page.items];
        filteredItems = List.from(items);
        if (searchQuery.isNotEmpty) {
          performSearch(searchQuery);
        }
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
  bool filterItem(Product item, String query) {
    return item.name.toLowerCase().contains(query.toLowerCase()) ||
        item.brand.toLowerCase().contains(query.toLowerCase()) ||
        item.size.toLowerCase().contains(query.toLowerCase());
  }

  @override
  void performSearch(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      super.performSearch(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    scrollController.dispose();
    super.dispose();
  }
}
