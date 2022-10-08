import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const cDark = Color(0xff1D1D1D);
const cWhite = Color(0xffFFFFFF);
const cDividerDark = Color(0xff2C2C2C);
const cDividerLight = Color.fromARGB(255, 210, 200, 200);
const cTransparent = Colors.transparent;
const cLightDart = Color(0xffFCFCFC);
const cDarkTextColor = Color(0xff989898);
ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: cDark,
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: cDarkTextColor,
      ),
    ),
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme).apply(bodyColor: cDarkTextColor),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  );
}

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: cWhite,
    useMaterial3: true,
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return GoogleFonts.sourceSansProTextTheme(base);
}

// theme
final darkTheme = _buildDarkTheme();

final lightTheme = _buildLightTheme();
