import 'package:inventario_app/src/domain/products/models/product.dart';

abstract class LoadImagesService {
  Future<String> load(Product product);
}
