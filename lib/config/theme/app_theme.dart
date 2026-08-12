import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const seedColor = Color(0xFF4338CA);

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.dark
  );

  final base = ThemeData(colorScheme: scheme, useMaterial3: true);

  return base.copyWith(
    scaffoldBackgroundColor: scheme.surface,
    textTheme: GoogleFonts.quicksandTextTheme(base.textTheme).apply( // tipografia utilizada con googlefonts 
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface
    ) 
  );
}