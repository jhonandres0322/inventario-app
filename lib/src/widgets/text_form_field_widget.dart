import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.labelText,
    this.readOnly = false,
    required this.validator,
    required this.onSaved,
    this.value,
    this.controller,
  });

  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final FormFieldValidator<String?>? validator;
  final FormFieldSetter onSaved;
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
      onSaved: onSaved,
      cursorColor: Colors.indigo,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: !readOnly,
      initialValue: controller == null ? value : null,
    );
  }
}
