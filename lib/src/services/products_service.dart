import 'dart:developer';

import 'package:inventario_app/src/core/infrastructure/app_kliiker.dart';
import 'package:inventario_app/src/core/infrastructure/app_supabase.dart';
import 'package:inventario_app/src/models/producto_model.dart';

class ProductsService {
  final AppKliiker _appKliiker = AppKliiker();

  Future<bool> saveProduct(Product product) async {
    List<String> imagenes = await _appKliiker.getImagesFromWebsite(
      product.codigoKliker,
    );

    product.foto1 = imagenes.first;
    product.foto2 = imagenes.last;
    product.calcularComision();
    product.calcularCostoReal();

    final isResponseNotEmpty = await AppSupabase().insert(
      'productos',
      product.toMap(),
    );

    return isResponseNotEmpty;
  }
}
