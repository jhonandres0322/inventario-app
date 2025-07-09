import 'package:flutter/material.dart';
import 'package:inventario_app/src/core/app_routes.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Bienvenido a MAD Store',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            _ButtonRedirectPageWidget(
              text: 'Administrador',
              icon: Icons.warehouse,
              routeTo: AppRoutes.admin,
            ),
            _ButtonRedirectPageWidget(
              text: 'Inventario',
              icon: Icons.inventory,
              routeTo: AppRoutes.inventoryList,
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonRedirectPageWidget extends StatelessWidget {
  const _ButtonRedirectPageWidget({
    required this.text,
    required this.icon,
    required this.routeTo,
  });

  final String text;
  final IconData icon;
  final String routeTo;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, routeTo);
          },
          icon: Icon(icon, size: size.height * 0.1),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: size.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
