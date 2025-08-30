import 'package:inventario_app/features/products/domain/vo/apparel_size/apparel_size.dart';

class ApparelSizeCodec {
  static String toRaw(ApparelSize size) {
    if (size is TopAlphaSize) {
      return 'top:${size.code.name}'; // xs, s, m, l, xl, xxl
    }
    if (size is BottomNumericSize) {
      return 'bottom:${size.waist}'; // 28, 30, 32...
    }
    if (size is OneSize) return 'única';
    throw ArgumentError('Tipo de talla no soportado: $size');
  }

  static ApparelSize parse(String raw) {
    final v = raw.trim().toLowerCase();

    // Única (tolerante con variantes comunes)
    if (v == 'one' ||
        v == 'one:os' ||
        v == 'unique' ||
        v == 'unica' ||
        v == 'única') {
      return const OneSize();
    }

    // Top alpha: "top:xs"
    if (v.startsWith('top:')) {
      final code = v.split(':').elementAtOrNull(1);
      switch (code) {
        case 'xs':
          return TopAlphaSize(TopAlphaCode.xs);
        case 's':
          return TopAlphaSize(TopAlphaCode.s);
        case 'm':
          return TopAlphaSize(TopAlphaCode.m);
        case 'l':
          return TopAlphaSize(TopAlphaCode.l);
        case 'xl':
          return TopAlphaSize(TopAlphaCode.xl);
        case 'xxl':
          return TopAlphaSize(TopAlphaCode.xxl);
      }
      throw ArgumentError('Talla top inválida: $raw');
    }

    // Bottom numeric: "bottom:32"
    if (v.startsWith('bottom:')) {
      final n = int.tryParse(v.split(':').elementAtOrNull(1) ?? '');
      if (n != null) return BottomNumericSize(n);
      throw ArgumentError('Talla bottom inválida (no numérica): $raw');
    }

    // Fallbacks útiles si te llega "m" o "32" sueltos:
    if (['xs', 's', 'm', 'l', 'xl', 'xxl'].contains(v)) {
      return TopAlphaSize(TopAlphaCode.values.byName(v));
    }
    final n = int.tryParse(v);
    if (n != null) return BottomNumericSize(n);

    throw ArgumentError('Formato de talla no reconocido: $raw');
  }
}

// Pequeña extensión utilitaria (Dart >=3)
extension on List<String> {
  String? elementAtOrNull(int i) => (i >= 0 && i < length) ? this[i] : null;
}
