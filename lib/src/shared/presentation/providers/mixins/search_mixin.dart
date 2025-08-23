import 'package:flutter/material.dart';

mixin SearchMixin<T> on ChangeNotifier {
  List<T> items = [];
  List<T> filteredItems = [];
  String searchQuery = '';

  void performSearch(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredItems = List.from(items);
    } else {
      filteredItems = items.where((item) => filterItem(item, query)).toList();
    }
    notifyListeners();
  }

  bool filterItem(T item, String query);
}
