import 'package:flutter/material.dart';
import 'package:inventario_app/src/ui/core/themes/app_colors.dart';
import 'package:inventario_app/src/ui/core/themes/border_text_form_field_util.dart';

class AppThemes {
  ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColors().secondary,
        titleTextStyle: TextStyle(
          color: AppColors().textAppBar,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors().secondary,
      ),
      textTheme: TextTheme(bodyMedium: TextStyle(color: AppColors().secondary)),
      scaffoldBackgroundColor: Color(0xFFEEE1CE),
      listTileTheme: ListTileThemeData(
        dense: true,
        titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
      ),
      useMaterial3: true,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all(Color(0xFF443629)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
          color: AppColors().secondary,
        ),
        labelStyle: TextStyle(color: AppColors().secondary),
        border: BorderTextFormFieldUtil.inputBorder(color: AppColors().primary),
        enabledBorder: BorderTextFormFieldUtil.inputBorder(
          color: AppColors().secondary,
        ),
        focusedBorder: BorderTextFormFieldUtil.inputBorder(
          color: AppColors().secondary,
        ),
        focusedErrorBorder: BorderTextFormFieldUtil.inputBorder(
          color: AppColors().error,
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: BorderTextFormFieldUtil.inputBorder(
            color: AppColors().secondary,
          ),
          border: BorderTextFormFieldUtil.inputBorder(
            color: AppColors().secondary,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors().secondary,
          foregroundColor: AppColors().textAppBar,
          textStyle: TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10.0),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors().secondary,
        foregroundColor: AppColors().textAppBar,
      ),
      cardTheme: CardThemeData(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
