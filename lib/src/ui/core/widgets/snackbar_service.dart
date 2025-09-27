import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';

class SnackBarService {
  static void showErrorSnackBar(
    BuildContext context,
    String errorMessage,
    Function resetState,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $errorMessage'),
          backgroundColor: AppColors().error,
        ),
      );
      resetState();
    });
  }

  static void showSuccessSnackBar(
    BuildContext context,
    String message,
    Function resetState,
  ) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors().success),
      );
      resetState();
    });
  }
}
