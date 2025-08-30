import 'package:flutter/material.dart';
import 'package:inventario_app/src_old/core/ui/app_colors.dart';

class GenericTextFormField extends StatelessWidget {
  const GenericTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.maxLength,
  });

  final TextInputType keyboardType;
  final String hintText;
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
      decoration: InputDecoration(hintText: hintText, labelText: label),
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
