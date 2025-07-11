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
  });

  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final bool readOnly;
  final FormFieldValidator<String?>? validator;
  final FormFieldSetter onSaved;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hintText, labelText: labelText),
      readOnly: readOnly,
      validator: validator,
      onSaved: onSaved,
      cursorColor: Colors.indigo,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: !readOnly,
      initialValue: value,
    );
  }
}
