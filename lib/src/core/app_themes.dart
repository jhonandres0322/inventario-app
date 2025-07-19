import 'package:flutter/material.dart';
import 'package:inventario_app/src/utils/border_text_form_field_util.dart';

class AppThemes {
  ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.indigo,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
          size: 35,
          applyTextScaling: true,
        ),
      ),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      listTileTheme: ListTileThemeData(
        dense: true,
        titleTextStyle: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      useMaterial3: true,
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.indigo)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w100,
          fontStyle: FontStyle.italic,
        ),
        border: BorderTextFormFieldUtil.inputBorder(color: Colors.indigo),
        enabledBorder: BorderTextFormFieldUtil.inputBorder(
          color: Colors.indigo,
        ),
        focusedBorder: BorderTextFormFieldUtil.inputBorder(
          color: Colors.indigo,
        ),
        focusedErrorBorder: BorderTextFormFieldUtil.inputBorder(
          color: Colors.indigo,
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: BorderTextFormFieldUtil.inputBorder(
            color: Colors.indigo,
          ),
          border: BorderTextFormFieldUtil.inputBorder(color: Colors.indigo),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10.0),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
