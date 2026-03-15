import 'package:flutter/material.dart';

class AppStyles {
  static TextTheme styles = const TextTheme(
    // Major Headings — SF Pro
    headlineLarge: TextStyle(
      fontSize: 34,
      fontFamily: 'sfPro',
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontFamily: 'sfPro',
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontFamily: 'sfPro',
      fontWeight: FontWeight.w500,
    ),

    // Rare/Accent Headings — DM Sans
    labelLarge: TextStyle(
      fontSize: 18,
      fontFamily: 'dmSans',
      fontWeight: FontWeight.w700,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      fontFamily: 'dmSans',
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontFamily: 'dmSans',
      fontWeight: FontWeight.w500,
    ),

    // Titles — Poppins
    titleLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w500,
    ),

    // Body — Poppins
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400,
    ),
  );
}
