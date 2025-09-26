import 'package:flutter/material.dart';
import 'package:inventario_app/src/config/routes/routes.dart';
import 'package:inventario_app/src/ui/core/viewmodels/generic_bottom_navigator_bar_provider.dart';
import 'package:provider/provider.dart';

class GenericBottomNavigatorBar extends StatelessWidget {
  const GenericBottomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final GenericBottomNavigatorBarProvider provider =
        Provider.of<GenericBottomNavigatorBarProvider>(context, listen: false);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Cargar'),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_2),
          label: 'Inventario',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Descargar'),
      ],
      currentIndex: provider.currentPage,
      onTap: (int index) {
        provider.currentPage = index;
        String? routeName = ModalRoute.of(context)?.settings.name;

        switch (index) {
          case 0:
            if (routeName != Routes.saveProduct) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.saveProduct,
                (route) => false,
              );
            }
            break;
          case 1:
            if (routeName != Routes.getProducts) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.getProducts,
                (route) => false,
              );
            }
            break;
          case 2:
            if (routeName != Routes.downloadProduct) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.downloadProduct,
                (route) => false,
              );
            }
            break;
          default:
        }
      },
    );
  }
}
