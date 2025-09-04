import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';

class GenericTextFormField extends StatelessWidget {
  const GenericTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.maxLength,
  });

  final TextInputType keyboardType;
  final String label;
  final bool readOnly;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: label, labelText: label),
      readOnly: readOnly,
      validator: validator,
      cursorColor: AppColors().secondary,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: !readOnly,
      textCapitalization: TextCapitalization.words,
      maxLength: maxLength,
    );
  }
}
