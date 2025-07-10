import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:inventario_app/src/app.dart';
import 'package:inventario_app/src/providers/inventario_provider.dart';
import 'package:inventario_app/src/providers/load_product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InventarioProvider()),
        ChangeNotifierProvider(create: (_) => LoadProductProvider()),
      ],
      child: App(),
    ),
  );
}
