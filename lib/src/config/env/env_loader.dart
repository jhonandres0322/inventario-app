import 'package:inventario_app/src/config/env/app_config.dart';
import 'package:inventario_app/src/config/env/dotenv_config.dart';

final class EnvLoader {
  static Future<AppConfig> load() async {
    return DotenvConfig.load();
  }
}
