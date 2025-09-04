import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';

enum SnackbarType { success, error, info }

class SnackbarCustomWidget {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final Color backgroundColor;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppColors().success;
        break;
      case SnackbarType.error:
        backgroundColor = AppColors().error;
        break;
      case SnackbarType.info:
        backgroundColor = AppColors().secondary;
        break;
    }

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
