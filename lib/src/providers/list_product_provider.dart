import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/utils/providers/list_provider_util.dart';

class ListProductProvider extends ListProviderUtil {
  List<ProductModel> products = [];

  List<ProductModel> get productosFiltrados => [];
}
