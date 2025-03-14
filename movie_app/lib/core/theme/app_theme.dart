import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1F1F1F);
  static const Color secondaryColor = Color(0xFF2C2C2C);
  static const Color accentColor = Color(0xFFFFD700);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0xFFB3B3B3);
  static const Color backgroundColor = Color(0xFF121212);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: secondaryColor,
        background: backgroundColor,
        error: Colors.red,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: textSecondaryColor,
          fontSize: 14,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryColor,
        selectedItemColor: accentColor,
        unselectedItemColor: textSecondaryColor,
      ),
      cardTheme: CardTheme(
        color: secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentColor),
        ),
        hintStyle: const TextStyle(color: textSecondaryColor),
        prefixIconColor: textSecondaryColor,
      ),
    );
  }
}
