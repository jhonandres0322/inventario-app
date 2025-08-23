import 'package:flutter/material.dart';
import 'package:inventario_app/src/shared/presentation/providers/mixins/search_mixin.dart';
import 'package:provider/provider.dart';

class GenericSearchBar<T> extends StatelessWidget
    implements PreferredSizeWidget {
  final String hintText;
  final double height;
  final EdgeInsets padding;
  final InputDecoration? decoration;

  const GenericSearchBar({
    super.key,
    this.hintText = 'Buscar...',
    this.height = 48.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        onChanged: (query) => Provider.of<SearchMixin<T>>(
          context,
          listen: false,
        ).performSearch(query),
        decoration:
            decoration ??
            InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
