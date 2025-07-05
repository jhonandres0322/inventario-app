import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoutes().routes,
      initialRoute: AppRoutes.home,
    );
  }
}
