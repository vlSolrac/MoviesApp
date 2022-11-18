import 'package:flutter/material.dart';
import 'package:movies/theme/themes.dart';

class AppTheme {
  static ThemeData ligthTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: ColorsTheme.primary,
      elevation: 5,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: ColorsTheme.primary,
      elevation: 5,
      centerTitle: true,
    ),
  );
}
