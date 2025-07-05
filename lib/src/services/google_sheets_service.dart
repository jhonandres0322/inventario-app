import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:inventario_app/src/models/producto_model.dart';

class GoogleSheetsService {
  static final _sheetId = dotenv.env['SHEET_ID'] ?? '';
  static final _range = 'ROPA!A:H';
  static final _apiKey = dotenv.env['API_KEY'] ?? '';

  static Future<List<Producto>> fetchProductos() async {
    final url =
        'https://sheets.googleapis.com/v4/spreadsheets/$_sheetId/values/$_range?key=$_apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rows = data['values'] as List;

      final dataRows = rows.skip(1);

      return dataRows.map((row) {
        final paddedRow = List<dynamic>.filled(8, '')
          ..setRange(0, row.length, row);
        return Producto.fromList(paddedRow);
      }).toList();
    } else {
      throw Exception('Error al cargar los datos: ${response.body}');
    }
  }
}
