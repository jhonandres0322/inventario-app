import 'package:flutter/material.dart';
import 'package:inventario_app/src/app.dart';
import 'package:inventario_app/src/providers/inventario_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => InventarioProvider())],
      child: App(),
    ),
  );
}
