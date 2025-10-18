import 'package:inventario_app/src/data/products/services/get_info_website/get_info_from_website_chevignon_americanino_esprit_service.dart';
import 'package:inventario_app/src/data/products/services/get_info_website/get_info_from_website_polo_atlantic_service.dart';
import 'package:inventario_app/src/domain/services/get_info_from_website_service.dart';

abstract class GetInfoFromWebsiteServiceFactory {
  GetInfoFromWebsiteService getService(String brand);
}

class DefaultLoadInfoFromWebsiteServiceFactory
    implements GetInfoFromWebsiteServiceFactory {
  @override
  GetInfoFromWebsiteService getService(String brand) {
    switch (brand.toLowerCase()) {
      case 'americanino':
      case 'chevignon':
      case 'esprit':
        return GetInfoFromWebsiteChevignonAmericaninoEspritService();
      case 'polo atlantic':
        return GetInfoFromWebsitePoloAtlanticService();
      default:
        throw Exception(
          'No LoadInfoFromWebsiteService found for brand: $brand',
        );
    }
  }
}
