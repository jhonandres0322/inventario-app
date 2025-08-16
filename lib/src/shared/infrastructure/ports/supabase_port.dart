import 'package:supabase_flutter/supabase_flutter.dart';

final class SupabaseClientPort {
  final SupabaseClient client;
  const SupabaseClientPort(this.client);

  Future<List<Map<String, dynamic>>> selectAll(String table) async {
    final List data = await client.from(table).select();
    return data.cast<Map<String, dynamic>>();
  }
}
