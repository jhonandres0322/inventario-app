import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:inventario_app/src/config/pagination/paging.dart';
import 'package:inventario_app/src/data/services/supabase/supabase_service.dart';
import 'package:inventario_app/src/domain/products/models/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final class ProductsRemoteService {
  final SupabaseService _supabaseService;

  const ProductsRemoteService(this._supabaseService);

  Future<List<Product>> getAll() async {
    final rows = await _supabaseService.selectAll('productos');
    return rows.map(Product.fromJson).toList();
  }

  Future<Page<Product>> getPage(PageParams params) async {
    final from = params.offset;
    final toInclusive = params.offset + params.limit;

    final rows = await _supabaseService.client
        .from('productos')
        .select()
        .order('createdAt', ascending: false)
        .range(from, toInclusive);
    final list = List<Map<String, dynamic>>.from(rows);
    final hasMore = list.length > params.limit;
    final sliced = hasMore ? list.sublist(0, params.limit) : list;
    final models = sliced.map(Product.fromJson).toList(growable: false);

    return Page<Product>(
      items: models,
      hasMore: hasMore,
      nextOffset: params.offset + models.length,
    );
  }

  Future<Product> saveProduct(Product product) async {
    final productSaved = await _supabaseService.client
        .from("productos")
        .insert(product.toJson())
        .select()
        .single();
    return Product.fromJson(productSaved);
  }

  Future<Product> getProductById(Product product) async {
    final productFound = await _supabaseService.client
        .from("productos")
        .select()
        .eq('id', product.id!)
        .single();

    return Product.fromJson(productFound);
  }

  Future<void> deleteProduct(Product productDelete) async {
    await _supabaseService.client
        .from('productos')
        .delete()
        .eq('id', productDelete.id!);
  }

  Future<List<Product>> findProductByFilters(
    List<Map<String, dynamic>> filters,
  ) async {
    var query = _supabaseService.client.from('productos').select();

    for (var filter in filters) {
      query = query.eq(filter['key'], filter['value']);
    }

    final rows = await query;
    final list = List<Map<String, dynamic>>.from(rows);
    final productsFound = list.map(Product.fromJson).toList(growable: false);

    return productsFound;
  }

  Future<Product> updateProduct(Product product) async {
    final productJson = product.toJson();

    final productUpdated = await _supabaseService.client
        .from('productos')
        .update(productJson)
        .eq('id', product.id!)
        .select()
        .single();

    return Product.fromJson(productUpdated);
  }

  Future<String> uploadFile({
    String? url,
    File? file,
    required String folder,
    required String fileName,
  }) async {
    try {
      // 1. Validación
      if (url == null && file == null) {
        throw Exception("Debes proporcionar un enlace o un archivo.");
      }

      late Uint8List bytes;

      // 2. Desde una URL
      if (url != null) {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode != 200) {
          throw Exception(
            'Error al descargar desde $url: ${response.statusCode}',
          );
        }

        bytes = response.bodyBytes;
      }

      // 3. Desde un archivo
      if (file != null) {
        bytes = await file.readAsBytes();
      }

      // 4. Subir a Supabase

      final storagePath = "$folder/$fileName";
      final uploadResponse = await _supabaseService.client.storage
          .from('images-inventario')
          .uploadBinary(
            storagePath,
            bytes,
            fileOptions: const FileOptions(
              contentType: 'image/jpeg',
              upsert: true,
            ),
          );
      if (uploadResponse.isEmpty) {
        throw Exception('Error al subir el archivo a Supabase');
      }

      // 5. Obtener URL publica

      final publicUrl = _supabaseService.client.storage
          .from('images-inventario')
          .getPublicUrl(storagePath);

      return publicUrl;
    } catch (e) {
      throw Exception('Error al subir archivo: $e');
    }
  }

  Future<bool> deleteImage({
    required String folder,
    required String fileName,
  }) async {
    try {
      final storagePath = "$folder/$fileName";

      // 1. Verificar si el archivo existe antes de eliminarlo
      final files = await _supabaseService.client.storage
          .from('images-inventario')
          .list(path: folder);

      final exists = files.any((file) => file.name == fileName);

      if (!exists) {
        log("El archivo no existe: $storagePath");
        return false;
      }

      // 2. Eliminar archivo
      await _supabaseService.client.storage.from('images-inventario').remove([
        storagePath,
      ]);

      log("Archivo eliminado: $storagePath");

      return true;
    } catch (e) {
      log("Error al eliminar archivo: $e");
      return false;
    }
  }
}
