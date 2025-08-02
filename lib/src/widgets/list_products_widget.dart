import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventario_app/src/core/ui/app_colors.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/providers/list_product_provider.dart';
import 'package:inventario_app/src/screens/detalle_producto_screen.dart';
import 'package:inventario_app/src/widgets/tile_info_card_widget.dart';

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
      double posPixeles = _scrollController.position.pixels;
      double posMaxScrollExtent = _scrollController.position.maxScrollExtent;
      if (posPixeles >= posMaxScrollExtent) {
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
      color: AppColors().secondary,
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
              return TileInfoCardWidget(
                title: widget.products[index].nombre,
                infoItems: [
                  InfoItem(Icons.store, widget.products[index].marca),
                  InfoItem(
                    Icons.straighten,
                    'Talla: ${widget.products[index].talla}',
                  ),
                ],
                trailingItems: [
                  InfoItem(
                    Icons.attach_money,
                    NumberFormat.currency(
                      locale: 'es_CO',
                      symbol: '\$',
                      decimalDigits: 0,
                    ).format(double.parse(widget.products[index].precioCompra)),
                    color: AppColors().success,
                  ),
                  InfoItem(
                    Icons.inventory_2,
                    'x${widget.products[index].cantidad}',
                    color: AppColors().secondary,
                  ),
                ],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalleProductoScreen(
                        producto: widget.products[index],
                      ),
                    ),
                  );
                },
              );
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
      child: CircularProgressIndicator(color: AppColors().secondary),
    );
  }
}
