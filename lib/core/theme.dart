import 'package:flutter/material.dart';

/// Centralized theme definitions for the application.
///
/// Provides both light and dark themes following WCAG AA contrast ratios.
class AppTheme {
  AppTheme._();

  // -- Brand Colors --
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF00BFA6);
  static const Color error = Color(0xFFE53935);

  // -- Light Theme --
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: primary,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
  );

  // -- Dark Theme (default for gallery view) --
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: primary,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
    ),
  );

  // -- Tag chip colors (assigned to tags based on hash) --
  static const List<Color> tagColors = [
    Color(0xFF6C63FF), // primary
    Color(0xFF00BFA6), // secondary
    Color(0xFFFF6D00), // orange
    Color(0xFF2979FF), // blue
    Color(0xFFFF4081), // pink
    Color(0xFF00E676), // green
    Color(0xFFFFD600), // yellow
    Color(0xFFAA00FF), // purple
  ];

  /// Pick a consistent color for a tag based on its name.
  static Color colorForTag(String tagName) {
    final index = tagName.hashCode.abs() % tagColors.length;
    return tagColors[index];
  }
}
