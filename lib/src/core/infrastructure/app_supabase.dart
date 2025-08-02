import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventario_app/src/utils/models/params_model_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppSupabase {
  static final AppSupabase _instance = AppSupabase._internal();

  factory AppSupabase() {
    return _instance;
  }

  AppSupabase._internal();

  static Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
  }

  SupabaseClient get client => Supabase.instance.client;

  Future<bool> insert(String tableName, Map<String, dynamic> data) async {
    log('data $data');
    final response = await client.from(tableName).insert(data).select();
    return response.first.isNotEmpty;
  }

  Future<List<T>> getAll<T>(
    String tableName,
    ParamsModelUtil params,
    T Function(Map<String, dynamic>) fromMap,
  ) async {
    final response = await client
        .from(tableName)
        .select()
        .range(params.from, params.to)
        .order(params.orderProperty, ascending: params.isOrderAscending);
    return (response as List)
        .map((item) => fromMap(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateOne<T>(
    String tableName,
    String recordId,
    Map<String, dynamic> Function() toMap,
  ) async {
    await client.from(tableName).update(toMap()).eq('id', recordId);
  }

  Future<void> deleteOne(String tableName, String idToDelete) async {
    await client.from(tableName).delete().eq('id', idToDelete);
  }
}
