import 'package:flutter/material.dart';

class BorderTextFormFieldUtil {
  static const double _borderRadius = 15.0;
  static const double _borderWidth = 1.0;

  static OutlineInputBorder inputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: BorderSide(color: color, width: _borderWidth),
    );
  }
}
