import 'package:inventario_app/src/config/app_config.dart';
import 'package:inventario_app/src/config/dotenv_config.dart';

final class EnvLoader {
  static Future<AppConfig> load() async {
    return DotenvConfig.load();
  }
}
