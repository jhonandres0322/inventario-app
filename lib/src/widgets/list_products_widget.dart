import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/providers/list_product_provider.dart';
import 'package:inventario_app/src/widgets/tile_product_widget.dart';

class ListProductsWidget extends StatefulWidget {
  const ListProductsWidget({
    super.key,
    required this.products,
    required this.onNextPage,
    required this.provider,
  });

  final List<ProductModel> products;
  final Function onNextPage;
  final ListProductProvider provider;

  @override
  State<ListProductsWidget> createState() => _ListProductsWidgetState();
}

class _ListProductsWidgetState extends State<ListProductsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      log(
        '_scrollController.position.pixels ${_scrollController.position.pixels}',
      );
      log(
        '_scrollController.position.maxScrollExtent ${_scrollController.position.maxScrollExtent}',
      );
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    widget.provider.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: Colors.indigoAccent,
      backgroundColor: Color(0xFFFFFFFF),
      onRefresh: () async {
        widget.provider.isRefresh = true;
        widget.onNextPage();
      },
      child: Stack(
        children: [
          ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return TileProductWidget(product: widget.products[index]);
            },
          ),
          if (widget.provider.isLoading)
            Positioned(
              bottom: 15,
              left: size.width * 0.5 - 30,
              child: const _LoadingIcon(),
            ),
        ],
      ),
    );
  }
}

class _LoadingIcon extends StatelessWidget {
  const _LoadingIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 50,
      width: 50,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: const CircularProgressIndicator(color: Colors.indigoAccent),
    );
  }
}
