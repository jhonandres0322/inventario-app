import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';

class BarcodeScanGuide extends StatelessWidget {
  const BarcodeScanGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width * 0.9, // Ancho del placeholder
        height: size.height * 0.3, // Alto del placeholder
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors().secondary, // Color del borde
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(12.0), // Bordes redondeados
          // ignore: deprecated_member_use
          color: Colors.black.withOpacity(0.2), // Fondo semitransparente
        ),
        child: Stack(
          children: [
            // Esquinas para resaltar el marco
          ],
        ),
      ),
    );
  }
}
