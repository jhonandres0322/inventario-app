import 'package:flutter/material.dart';

import 'package:inventario_app/src/ui/home/widgets/home_body.dart';
import 'package:inventario_app/src/ui/home/widgets/home_bottom_navigator_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final String _titleText = 'Bienvenido a MAD Store';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titleText)),
      body: HomeBody(),
      bottomNavigationBar: HomeBottomNavigatorBar(),
    );
  }
}
