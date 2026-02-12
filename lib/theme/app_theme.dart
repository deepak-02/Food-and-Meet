import 'package:flutter/material.dart';

class AppTheme {
  static const Color accent = Color(0xFF13EC5B);
  static const Color secondary = Color(0xFFB9FF7F);
  static const Color text1 = Color(0xFFFFFFFF);
  static final Color text2 = Colors.grey;
  static final Color text3 = Colors.white.withValues(alpha: 0.5);
  static final Color text4 = Colors.white24;
  static final Color inputBackground = Color(0xBB2C2C2E);
  static final Color hint = Colors.white.withValues(alpha: 0.4);
  static final Color buttonForeground = Colors.black;
  static final Color scaffoldBackgroundColor = Colors.black;

  static const Color errorColor = Colors.redAccent;


  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}
