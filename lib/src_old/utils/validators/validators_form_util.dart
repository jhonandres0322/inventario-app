mixin ValidatorsFormUtil {
  String? validateNumberForm(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El valor es obligatorio';
    }

    final trimmed = value.trim();

    final number = double.tryParse(trimmed);
    if (number == null) {
      return 'Debe ser un número válido';
    }

    final regex = RegExp(r'^0[0-9]+$');
    if (regex.hasMatch(trimmed)) {
      return 'No debe tener ceros al inicio';
    }

    return null;
  }

  String? validateEmpty(String? value) {
    if (value == null) return 'Valo invalido';
    if (value.isEmpty) return 'Campo obligatorio';
    if (value == ' ') return 'Campo obligatorio';
    return null;
  }
}
