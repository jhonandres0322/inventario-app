import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/domain/app_routes.dart';
import 'package:inventario_app/src/core/ui/app_themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes().routes,
      initialRoute: AppRoutes.initial,
      theme: AppThemes().light,
    );
  }
}
