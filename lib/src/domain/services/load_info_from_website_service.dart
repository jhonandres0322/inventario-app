import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/domain/services/dtos/load_info_from_website_dto.dart';

abstract class LoadInfoFromWebsiteService {
  Future<LoadInfoFromWebsiteDto> load(Product product);
}
