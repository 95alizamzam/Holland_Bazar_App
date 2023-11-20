import 'package:flutter/material.dart';
import 'package:tsc_app/core/fonts/font.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Color(0XFF222226),
      ),
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.metropolisSemiBold,
        color: const Color(0XFF222226),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: const Color(0xFF4A4B4D),
        fontFamily: AppFonts.metropolisExtraBold,
      ),
      bodySmall: TextStyle(
        color: const Color(0xFF7C7D7E),
        fontFamily: AppFonts.metropolisMedium,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFE5A01),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        fixedSize: const Size(double.maxFinite, 56),
        textStyle: TextStyle(
          fontFamily: AppFonts.metropolisSemiBold,
        ),
      ),
    ),
  );
}
