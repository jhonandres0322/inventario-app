import 'package:inventario_app/src/data/products/services/images/load_images_chevignon_americanino_service.dart';
import 'package:inventario_app/src/data/products/services/images/load_images_polo_atlantic_service.dart';
import 'package:inventario_app/src/domain/services/load_images_service.dart';

abstract class LoadImagesServiceFactory {
  LoadImagesService getService(String brand);
}

class DefaultLoadImagesServiceFactory implements LoadImagesServiceFactory {
  @override
  LoadImagesService getService(String brand) {
    switch (brand.toLowerCase()) {
      case 'americanino':
        return LoadImagesChevignonAmericaninoService();
      case 'chevignon':
        return LoadImagesChevignonAmericaninoService();
      case 'polo atlantic':
        return LoadImagesPoloAtlanticService();
      default:
        throw Exception('No LoadImagesService found for brand: $brand');
    }
  }
}
