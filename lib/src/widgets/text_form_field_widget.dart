import 'package:flutter/material.dart';

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
  });

  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final FormFieldValidator<String?>? validator;
  final ValueChanged<String>? onChanged;
  final String? value;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hintText, labelText: labelText),
      readOnly: readOnly,
      validator: validator,
      cursorColor: Colors.indigo,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: !readOnly,
      onChanged: onChanged,
      initialValue: controller == null ? value : null,
      textCapitalization: TextCapitalization.words,
    );
  }
}
