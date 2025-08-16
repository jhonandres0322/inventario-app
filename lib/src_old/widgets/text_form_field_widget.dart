import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventario_app/src_old/core/ui/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.labelText,
    this.readOnly = false,
    required this.validator,
    this.onChanged,
    this.value,
    this.controller,
    this.maxLength,
  });

  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String>? onChanged;
  final String? value;
  final TextEditingController? controller;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hintText, labelText: labelText),
      readOnly: readOnly,
      validator: validator,
      cursorColor: AppColors().secondary,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: !readOnly,
      onChanged: onChanged,
      initialValue: controller == null ? value : null,
      textCapitalization: TextCapitalization.words,
      maxLength: maxLength,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
