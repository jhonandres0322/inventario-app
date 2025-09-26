import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'package:inventario_app/src/domain/services/load_images_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

class LoadImagesChevignonAmericaninoService implements LoadImagesService {
  @override
  Future<String> load(Product product) async {
    final hostname = _buildHostname(product.brand);
    final urlSearch =
        '$hostname/${product.barcode}?_q=${product.barcode}&map=ft';
    log("**** urlSearch --> $urlSearch ");
    final response = await http.get(Uri.parse(urlSearch));

    if (response.statusCode != 200) {
      return '';
    }

    final document = parse(response.body);

    final images = document
        .getElementsByClassName('vtex-product-summary-2-x-image')
        .take(2)
        .map((element) => element.attributes['src'])
        .where((src) => src != null)
        .cast<String>()
        .toList();

    return images.join(",");
  }

  String _buildHostname(String brand) {
    switch (brand.toLowerCase()) {
      case 'americanino':
        return 'https://www.$brand.com';
      case 'chevignon':
        return 'https://www.$brand.com.co';
      default:
        return '';
    }
  }
}
