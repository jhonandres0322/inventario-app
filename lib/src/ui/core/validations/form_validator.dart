class FormValidator {
  // Validación para campos de texto obligatorios
  static String? requiredText(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'El $fieldName es obligatorio';
    }
    return null;
  }

  // Validación para campos de texto con longitud mínima
  static String? minLengthText(String? value, String fieldName, int minLength) {
    if (value == null || value.isEmpty) {
      return 'El $fieldName es obligatorio';
    }
    if (value.length < minLength) {
      return 'El $fieldName debe tener al menos $minLength caracteres';
    }
    return null;
  }

  // Validación para números (precios, cantidades, porcentajes)
  static String? number(
    String? value,
    String fieldName, {
    bool allowEmpty = false,
  }) {
    if (value == null || value.isEmpty) {
      if (allowEmpty) return null;
      return 'El $fieldName es requerido';
    }
    final number = double.tryParse(value);
    if (number == null) return 'Debe ser un número válido';
    if (number < 0) return 'El $fieldName no puede ser negativo';
    if (value.startsWith('0') && !value.startsWith('0.') && value != '0') {
      return 'No se permiten ceros a la izquierda';
    }
    return null;
  }

  // Validación para dropdowns obligatorios
  static String? requiredDropdown(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'El $fieldName es requerido';
    }
    return null;
  }
}
