import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/domain/services/dtos/load_info_from_website_dto.dart';
import 'package:inventario_app/src/domain/services/load_info_from_website_service.dart';

class LoadInfoFromWebsitePoloAtlanticService
    implements LoadInfoFromWebsiteService {
  @override
  Future<LoadInfoFromWebsiteDto> load(Product product) async {
    final urlSearch = _buildUrl(product.barcode);
    List<String?> images = [];

    final response = await http.get(Uri.parse(urlSearch));

    if (response.statusCode != 200) {
      return LoadInfoFromWebsiteDto.fromJson({"name": '', "images": ''});
    }
    final document = parse(response.body);

    final info = document
        .getElementsByTagName('img')
        .firstWhere(
          (element) => element.className.contains('t4s-product-main-img'),
        );

    final attributes = info.attributes;
    final url = attributes['data-src'] ?? '';
    final dataWidths = attributes['data-widths'] ?? '';

    images.add(changeWidth(url, dataWidths));

    final String name = attributes['alt'] ?? '';

    return LoadInfoFromWebsiteDto(name: name, images: images.join(','));
  }

  String _buildUrl(String barcode) {
    String barcodeSplitted = barcode.split('T').first;
    return "https://poloatlantic.com.co/search?type=product&options[unavailable_products]=last&options[prefix]=last&q=$barcodeSplitted";
  }

  String? changeWidth(String url, String dataWidths) {
    final int widthNew = 200;
    try {
      // Validar que la URL es un string no vacío
      if (url.isEmpty) {
        throw Exception('La URL no es válida o está vacía.');
      }

      // Convertir el string de dataWidths a una lista
      List<int> widthsArray;
      try {
        // Remover corchetes y convertir a lista de enteros
        final cleanedWidths = dataWidths.replaceAll(RegExp(r'[\[\]\s]'), '');
        widthsArray = cleanedWidths
            .split(',')
            .map((e) => int.parse(e))
            .toList();
        if (widthsArray.isEmpty) {
          throw Exception('dataWidths no es una lista válida.');
        }
      } catch (e) {
        throw Exception('Error al parsear dataWidths: $e');
      }

      // Validar que newWidth está en la lista
      if (!widthsArray.contains(widthNew)) {
        throw Exception(
          'El ancho $widthNew no está en la lista de anchos permitidos.',
        );
      }

      // Expresión regular para encontrar el parámetro width en la URL
      final widthRegex = RegExp(r'[?&]width=\d+');
      String newUrl;

      if (widthRegex.hasMatch(url)) {
        // Si la URL ya tiene un parámetro width, reemplazarlo
        newUrl = "https:${url.replaceAll(widthRegex, 'width=$widthNew')}";
      } else {
        // Si no hay parámetro width, añadirlo
        final separator = url.contains('?') ? '&' : '?';
        newUrl =
            'https:$url$separator'
            'width=$widthNew'; // Corrección aquí
      }

      return newUrl;
    } catch (e) {
      return null;
    }
  }
}
