import 'package:flutter/material.dart';
import 'package:inventario_app/src_old/core/ui/app_colors.dart';

class GenericDropdownButtonFormField<T> extends StatelessWidget {
  final String hintText;
  final String labelText;
  final T? value;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T?>? validator;
  final Widget Function(T)? itemBuilder;
  final InputDecoration? decoration;

  const GenericDropdownButtonFormField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.itemBuilder,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: items.contains(value) ? value : null,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: itemBuilder != null
              ? itemBuilder!(item)
              : Text(item.toString()),
        );
      }).toList(),
      decoration:
          decoration ??
          InputDecoration(
            hintText: hintText,
            labelText: labelText,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors().secondary),
            ),
          ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
