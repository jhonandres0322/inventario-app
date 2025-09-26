import 'package:supabase_flutter/supabase_flutter.dart';

final class SupabaseService {
  final SupabaseClient client;
  const SupabaseService(this.client);

  Future<List<Map<String, dynamic>>> selectAll(String table) async {
    final List data = await client.from(table).select();
    return data.cast<Map<String, dynamic>>();
  }
}
