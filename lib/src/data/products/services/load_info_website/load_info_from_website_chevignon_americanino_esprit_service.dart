import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:inventario_app/src/domain/services/dtos/load_info_from_website_dto.dart';

import 'package:inventario_app/src/domain/services/load_info_from_website_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

class LoadInfoFromWebsiteChevignonAmericaninoEspritService
    implements LoadInfoFromWebsiteService {
  @override
  Future<LoadInfoFromWebsiteDto> load(Product product) async {
    final hostname = _buildHostname(product.brand);
    final urlSearch =
        '$hostname/${product.barcode}?_q=${product.barcode}&map=ft';
    log("**** urlSearch --> $urlSearch ");
    final response = await http.get(Uri.parse(urlSearch));

    if (response.statusCode != 200) {
      return LoadInfoFromWebsiteDto.fromJson({"name": '', "images": ''});
    }

    final document = parse(response.body);

    final images = document
        .getElementsByClassName('vtex-product-summary-2-x-image')
        .take(2)
        .map((element) => element.attributes['src'])
        .where((src) => src != null)
        .cast<String>()
        .toList();

    final name = document
        .getElementsByClassName(
          'vtex-product-summary-2-x-productBrand vtex-product-summary-2-x-brandName t-body',
        )
        .first
        .text;

    return LoadInfoFromWebsiteDto(name: name, images: images.join(","));
  }

  String _buildHostname(String brand) {
    switch (brand.toLowerCase()) {
      case 'americanino':
        return 'https://www.$brand.com';
      case 'chevignon':
      case 'esprit':
        return 'https://www.$brand.com.co';
      default:
        return '';
    }
  }
}
