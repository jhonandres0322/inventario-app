import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class AppKliiker {
  Future<List<String>> getImagesFromWebsite(String barcode) async {
    final urlSearchProduct =
        'https://www.tienda.kliiker.com/$barcode?_q=$barcode&map=ft';

    final response = await http.get(Uri.parse(urlSearchProduct));

    if (response.statusCode != 200) {
      throw Exception('Error al cargar la página del producto');
    }

    final document = parse(response.body);

    final imagenes = document
        .getElementsByClassName('vtex-product-summary-2-x-image')
        .take(2)
        .map((elemento) => elemento.attributes['src'])
        .where((src) => src != null)
        .cast<String>()
        .toList();

    return imagenes;
  }
}
