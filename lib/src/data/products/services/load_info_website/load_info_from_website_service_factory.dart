import 'package:inventario_app/src/data/products/services/load_info_website/load_info_from_website_chevignon_americanino_esprit_service.dart';
import 'package:inventario_app/src/data/products/services/load_info_website/load_info_from_website_polo_atlantic_service.dart';
import 'package:inventario_app/src/domain/services/load_info_from_website_service.dart';

abstract class LoadInfoFromWebsiteServiceFactory {
  LoadInfoFromWebsiteService getService(String brand);
}

class DefaultLoadInfoFromWebsiteServiceFactory
    implements LoadInfoFromWebsiteServiceFactory {
  @override
  LoadInfoFromWebsiteService getService(String brand) {
    switch (brand.toLowerCase()) {
      case 'americanino':
      case 'chevignon':
      case 'esprit':
        return LoadInfoFromWebsiteChevignonAmericaninoEspritService();
      case 'polo atlantic':
        return LoadInfoFromWebsitePoloAtlanticService();
      default:
        throw Exception(
          'No LoadInfoFromWebsiteService found for brand: $brand',
        );
    }
  }
}
