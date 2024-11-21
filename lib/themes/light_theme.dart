import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.red,
    // textTheme: GoogleFonts.montserratSubrayadaTextTheme(),
  brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.grey[400]!,
      primary: Colors.grey[300]!,
      secondary: Colors.grey[200]!,
      tertiary: Colors.grey[700]!,
      surfaceTint: Colors.redAccent,
      surfaceVariant: Colors.red[300],
      surface: Colors.redAccent[100]!,
      outlineVariant: Colors.grey[800]!,
      outline: Colors.black,
    )

);