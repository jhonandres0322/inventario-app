import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    final response = await client.from(tableName).insert(data).select();
    return response.first.isNotEmpty;
  }
}
