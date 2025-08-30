import 'package:inventario_app/features/products/domain/vo/brand/brand.dart';

class BrandCodec {
  const BrandCodec._(); // evita instanciación

  /// Enum -> código estable (minúsculas, sin espacios/&, etc.) para JSON/DB.
  static String toRaw(Brand brand) => switch (brand) {
    Brand.americanEagle => 'americaneagle',
    Brand.chevignon => 'chevignon',
    Brand.guess => 'guess',
    Brand.columbia => 'columbia',
    Brand.hollister => 'hollister',
    Brand.uniqlo => 'uniqlo',
    Brand.bershka => 'bershka',
    Brand.lacoste => 'lacoste',
    Brand.springfield => 'springfield',
    Brand.tommyHilfiger => 'tommyhilfiger',
    Brand.puma => 'puma',
    Brand.mango => 'mango',
    Brand.forever21 => 'forever21',
    Brand.levis => 'levis',
    Brand.stradivarius => 'stradivarius',
    Brand.esprit => 'esprit',
    Brand.reebok => 'reebok',
    Brand.adidas => 'adidas',
    Brand.hm => 'hm',
    Brand.underArmour => 'underarmour',
    Brand.pullAndBear => 'pullandbear',
    Brand.zara => 'zara',
    Brand.massimoDutti => 'massimodutti',
    Brand.nike => 'nike',
    Brand.americanino => 'americanino',
  };

  /// String -> Enum. Acepta variantes con espacios, &, guiones, etc.
  static Brand parse(String raw) {
    final norm = _normalize(raw);
    return switch (norm) {
      'americaneagle' => Brand.americanEagle,
      'chevignon' => Brand.chevignon,
      'guess' => Brand.guess,
      'columbia' => Brand.columbia,
      'hollister' => Brand.hollister,
      'uniqlo' => Brand.uniqlo,
      'bershka' => Brand.bershka,
      'lacoste' => Brand.lacoste,
      'springfield' => Brand.springfield,
      'tommyhilfiger' => Brand.tommyHilfiger,
      'puma' => Brand.puma,
      'mango' => Brand.mango,
      'forever21' => Brand.forever21,
      'levis' => Brand.levis,
      'stradivarius' => Brand.stradivarius,
      'esprit' => Brand.esprit,
      'reebok' => Brand.reebok,
      'adidas' => Brand.adidas,
      'hm' => Brand.hm,
      'underarmour' || 'underarmor' => Brand.underArmour, // tolera ambas
      'pullandbear' => Brand.pullAndBear,
      'zara' => Brand.zara,
      'massimodutti' => Brand.massimoDutti,
      'nike' => Brand.nike,
      'americanino' => Brand.americanino,
      _ => throw ArgumentError('Marca no soportada $raw'),
    };
  }

  static Brand? tryParse(String? raw) {
    if (raw == null) return null;
    try {
      return parse(raw);
    } catch (_) {
      return null;
    }
  }

  /// Lista de códigos canónicos válidos (útil para validación/UI).
  static const List<String> validCodes = [
    'americaneagle',
    'chevignon',
    'guess',
    'columbia',
    'hollister',
    'uniqlo',
    'bershka',
    'lacoste',
    'springfield',
    'tommyhilfiger',
    'puma',
    'mango',
    'forever21',
    'levis',
    'stradivarius',
    'esprit',
    'reebok',
    'adidas',
    'hm',
    'underarmour',
    'pullandbear',
    'zara',
    'massimodutti',
    'nike',
    'americanino',
  ];

  /// Normaliza: minúsculas y SOLO [a-z0-9], elimina espacios, &,-,_, acentos, etc.
  static String _normalize(String raw) {
    final lower = raw.trim().toLowerCase();
    final sb = StringBuffer();
    for (final r in lower.runes) {
      final ch = String.fromCharCode(r);
      final code = ch.codeUnitAt(0);
      final isAZ = code >= 97 && code <= 122; // a-z
      final is09 = code >= 48 && code <= 57; // 0-9
      if (isAZ || is09) {
        sb.write(ch);
      } else if (ch == 'ñ') {
        sb.write('n');
      }
    }
    return sb.toString();
  }
}
