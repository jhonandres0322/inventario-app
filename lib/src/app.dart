import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:inventario_app/src/ui/core/themes/app_theme.dart';
import 'package:inventario_app/src/ui/products/get_products/viewmodels/get_products_provider.dart';
import 'package:inventario_app/src/config/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetProductsProvider()..load()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.map,
        initialRoute: Routes.home,
        theme: AppThemes().light,
      ),
    );
  }
}
