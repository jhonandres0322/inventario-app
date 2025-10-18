import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:inventario_app/src/domain/services/dtos/get_info_from_website_dto.dart';

import 'package:inventario_app/src/domain/services/get_info_from_website_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';

class GetInfoFromWebsiteChevignonAmericaninoEspritService
    implements GetInfoFromWebsiteService {
  @override
  Future<GetInfoFromWebsiteDto> getInfo(Product product) async {
    final hostname = _buildHostname(product.brand);
    final urlSearch =
        '$hostname/${product.barcode}?_q=${product.barcode}&map=ft';
    final response = await http.get(Uri.parse(urlSearch));

    if (response.statusCode != 200) {
      return GetInfoFromWebsiteDto.fromJson({"name": '', "images": ''});
    }

    final document = parse(response.body);

    final image = document
        .getElementsByClassName('vtex-product-summary-2-x-image')
        .take(1)
        .map((element) => element.attributes['src'])
        .where((src) => src != null)
        .cast<String>()
        .first;

    final name = document
        .getElementsByClassName(
          'vtex-product-summary-2-x-productBrand vtex-product-summary-2-x-brandName t-body',
        )
        .first
        .text;

    return GetInfoFromWebsiteDto(
      name: name ?? 'Sin nombre',
      images: image ?? 'Sin imagen',
    );
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
