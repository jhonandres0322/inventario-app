import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_theme.dart';
import 'package:inventario_app/src/features/products/presentation/providers/get_products_provider.dart';
import 'package:inventario_app/src/routes.dart';
import 'package:inventario_app/src/shared/presentation/providers/mixins/search_mixin.dart';
import 'package:provider/provider.dart';

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
