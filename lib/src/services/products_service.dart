import 'package:inventario_app/src/core/infrastructure/app_kliiker.dart';
import 'package:inventario_app/src/core/infrastructure/app_supabase.dart';
import 'package:inventario_app/src/models/product_model.dart';
import 'package:inventario_app/src/utils/params_model_util.dart';

class ProductsService {
  final AppKliiker _appKliiker = AppKliiker();

  Future<bool> saveProduct(ProductModel product) async {
    List<String> imagenes = await _appKliiker.getImagesFromWebsite(
      product.codigoKliker,
    );

    product.foto1 = imagenes.first;
    product.foto2 = imagenes.last;
    product.calculateCommision();
    product.calculateCommision();

    final isResponseNotEmpty = await AppSupabase().insert(
      'productos',
      product.toMap(),
    );

    return isResponseNotEmpty;
  }

  Future<List<ProductModel>> getProducts(ParamsModelUtil params) async {
    final List<ProductModel> products = await AppSupabase()
        .getAll<ProductModel>('productos', params, ProductModel.fromMap);
    return products;
  }
}
