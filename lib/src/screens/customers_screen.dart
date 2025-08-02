import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/domain/app_routes.dart';
import 'package:inventario_app/src/core/ui/app_colors.dart';
import 'package:inventario_app/src/providers/customers_provider.dart';
import 'package:inventario_app/src/widgets/list_customer_widget.dart';
import 'package:provider/provider.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CustomersProvider provider = Provider.of<CustomersProvider>(context);
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          provider.clearValueSearch();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Clientes'),
          bottom: _SearchCustomersWidget(),
          toolbarHeight: size.height * 0.08,
          automaticallyImplyLeading: false,
        ),
        body: Builder(
          builder: (context) {
            return SizedBox.expand(child: _ListCustomers());
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.person_add_rounded),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.createCustomer);
          },
        ),
      ),
    );
  }
}

class _ListCustomers extends StatelessWidget {
  const _ListCustomers();

  @override
  Widget build(BuildContext context) {
    final CustomersProvider provider = Provider.of<CustomersProvider>(context);
    return ListCustomerWidget(
      onNextPage: () => provider.loadCustomersNews(),
      customers: provider.filteredCustomers,
      provider: provider,
    );
  }
}

class _SearchCustomersWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const _SearchCustomersWidget();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final CustomersProvider provider = Provider.of<CustomersProvider>(
      context,
      listen: false,
    );
    return PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: TextField(
          onChanged: (value) => provider.actualizarBusqueda(value),
          cursorColor: AppColors().secondary,
          decoration: InputDecoration(
            hintText: 'Buscar por nombre',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: AppColors().textAppBar,
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
