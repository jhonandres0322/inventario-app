import 'package:flutter/material.dart';

import 'package:inventario_app/src/app.dart';
import 'src/config/di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(App());
}
