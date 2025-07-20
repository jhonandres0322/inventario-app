import 'package:flutter/material.dart';
import 'package:inventario_app/src/app.dart';
import 'package:inventario_app/src/core/infrastructure/app_supabase.dart';
import 'package:inventario_app/src/providers/detail_product_provider.dart';
import 'package:inventario_app/src/providers/inventario_provider.dart';
import 'package:inventario_app/src/providers/list_product_provider.dart';
import 'package:inventario_app/src/providers/load_product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await AppSupabase.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InventarioProvider()),
        ChangeNotifierProvider(create: (_) => LoadProductProvider()),
        ChangeNotifierProvider(create: (_) => ListProductProvider()),
        ChangeNotifierProvider(create: (_) => DetailProductProvider()),
      ],
      child: App(),
    ),
  );
}
