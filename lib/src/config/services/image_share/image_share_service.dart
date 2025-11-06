import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageShareService {
  static Future<void> shareImagesFromUrls(
    List<String> imageUrls,
    BuildContext context,
  ) async {
    if (imageUrls.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay imágenes para compartir')),
      );
      return;
    }

    final tempFiles = <File>[];

    try {
      final directory = await getTemporaryDirectory();

      final responses = await Future.wait(
        imageUrls.map((url) => http.get(Uri.parse(url))),
      );

      for (int i = 0; i < responses.length; i++) {
        final response = responses[i];
        if (response.statusCode == 200) {
          final fileName =
              'temp_image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
          final filePath = '${directory.path}/$fileName';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
          tempFiles.add(file);
        }
      }

      if (tempFiles.isEmpty) {
        throw Exception('No se pudieron descargar las imágenes.');
      }

      final xFiles = tempFiles.map((file) => XFile(file.path)).toList();

      // ignore: deprecated_member_use
      final result = await Share.shareXFiles(xFiles);

      if (result.status == ShareResultStatus.success) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Imágenes compartidas exitosamente')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al compartir imágenes: ${e.toString()}')),
      );
    } finally {
      for (final file in tempFiles) {
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
  }
}
