import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/ui/app_colors.dart';
import 'package:inventario_app/src/models/customer_model.dart';
import 'package:inventario_app/src/providers/list_customers_provider.dart';
import 'package:inventario_app/src/screens/customer_detail_screen.dart';
import 'package:inventario_app/src/widgets/tile_info_card_widget.dart';

class ListCustomerWidget extends StatefulWidget {
  const ListCustomerWidget({
    super.key,
    required this.customers,
    required this.onNextPage,
    required this.provider,
  });

  final List<CustomerModel> customers;
  final Function onNextPage;
  final ListCustomersProvider provider;

  @override
  State<ListCustomerWidget> createState() => _ListCustomerWidgetState();
}

class _ListCustomerWidgetState extends State<ListCustomerWidget> {
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
            physics: AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            itemCount: widget.customers.length,
            itemBuilder: (context, index) {
              return TileInfoCardWidget(
                title: widget.customers[index].nombre,
                infoItems: [
                  InfoItem(Icons.phone, widget.customers[index].telefono),
                  InfoItem(
                    Icons.location_on,
                    'Dirección: ${widget.customers[index].direccion}',
                  ),
                ],
                trailingItems: [],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CustomerDetailScreen(
                        customerId: widget.customers[index].id,
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
