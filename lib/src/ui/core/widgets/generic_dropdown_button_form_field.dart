import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';

class GenericDropdownButtonFormField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String?>? validator;
  final InputDecoration? decoration;
  final bool inUpperCaseText;

  const GenericDropdownButtonFormField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.decoration,
    this.inUpperCaseText = false,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.09,
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(inUpperCaseText ? item.toUpperCase() : item),
          );
        }).toList(),
        decoration:
            decoration ??
            InputDecoration(
              hintText: label,
              labelText: label,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors().secondary),
              ),
            ),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
