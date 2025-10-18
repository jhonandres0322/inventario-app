import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageShareService {
  static Future<void> shareImageFromUrl(
    String imageUrl,
    BuildContext context,
  ) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Error al descargar la imagen');
      }

      final directory = await getTemporaryDirectory();
      final fileName =
          'temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // Paso 3: Crear XFile y compartir
      final xFile = XFile(filePath);
      // ignore: deprecated_member_use
      final result = await Share.shareXFiles([xFile]);

      // Paso 4: Verificar resultado (opcional)
      if (result.status == ShareResultStatus.success) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Imagen compartida exitosamente')),
        );
      }

      // Paso 5: Limpiar archivo temporal (buena práctica)
      await file.delete();
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }
}
