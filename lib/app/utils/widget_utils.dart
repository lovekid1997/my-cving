import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const cDark = Color(0xff1D1D1D);
const cWhite = Color(0xffFFFFFF);
const cDividerDark = Color(0xff2C2C2C);
const cDividerLight = Color.fromARGB(255, 210, 200, 200);

ThemeData _buildDarkTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    onPrimary: Colors.white,
    error: const Color(0xFFB00020),
    background: const Color(0xFF202124),
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    primaryColorDark: const Color(0xFF0050a0),
    primaryColorLight: secondaryColor,
    indicatorColor: Colors.white,
    canvasColor: const Color(0xFF202124),
    scaffoldBackgroundColor: cDark,
  );
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  );
}

ThemeData _buildLightTheme() {
  const Color primaryColor = Color(0xFF0175c2);
  const Color secondaryColor = Color(0xFF13B9FD);
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    error: const Color(0xFFB00020),
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
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

// widget const
const kDivider = Divider(
  height: 1,
  thickness: 1,
);
