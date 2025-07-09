import 'package:flutter/material.dart';

class AppThemes {
  ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.deepPurple,
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
    );
  }
}
