import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:inventario_app/src/domain/services/dtos/get_info_from_website_dto.dart';

abstract class GetInfoFromWebsiteService {
  Future<GetInfoFromWebsiteDto> getInfo(Product product);
}
