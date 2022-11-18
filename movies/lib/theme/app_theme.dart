import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Colors.deepPurple;
  static Color? second = Colors.deepPurple[700];

  static ThemeData ligthTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: primary,
      elevation: 5,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: primary,
      elevation: 5,
      centerTitle: true,
    ),
  );
}
