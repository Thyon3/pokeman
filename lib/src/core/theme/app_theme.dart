import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme appTextTheme = TextTheme(
  titleLarge: GoogleFonts.lato(
    textStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
  ),
  bodyLarge: GoogleFonts.lato(
    textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
  ),
  bodyMedium: GoogleFonts.lato(
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
  ),
);

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: Brightness.light,
      ),
      textTheme: appTextTheme,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.red,
        brightness: Brightness.dark,
      ),
      textTheme: appTextTheme,
    );
  }
}
