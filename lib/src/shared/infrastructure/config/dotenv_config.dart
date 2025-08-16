import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inventario_app/src/core/config/app_config.dart';

final class DotenvConfig implements AppConfig {
  DotenvConfig._();

  static Future<DotenvConfig> load({String fileName = '.env'}) async {
    await dotenv.load(fileName: fileName);
    return DotenvConfig._();
  }

  String _get(String key, {String? def}) =>
      dotenv.env[key] ?? def ?? (throw StateError('Missing env: $key'));

  @override
  String get supabaseUrl => _get('SUPABASE_URL', def: '');

  @override
  String get supabaseAnonKey => _get('SUPABASE_ANON_KEY', def: '');
}
