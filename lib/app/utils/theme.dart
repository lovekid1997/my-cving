import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// colors
const cDark = Color(0xff1D1D1D);
const cWhite = Color(0xffFFFFFF);
const cDividerDark = Color(0xff2C2C2C);
const cDividerLight = Color.fromARGB(255, 210, 200, 200);
const cTransparent = Colors.transparent;

// colors text
const cTextLight = Color(0xff717171);

// colors dark text
const cTextLightDark = Color(0xffF1F1F1);
const cTextNormalDark = Color(0xff999999);
const cTextDark = Color(0xff636363);

ThemeData _buildDarkTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: cDark,
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused)) {
              return cTextLightDark;
            }
            return cTextNormalDark;
          },
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: cTextNormalDark),
  );
  return base.copyWith(
    textTheme:
        _buildTextTheme(base.textTheme).apply(bodyColor: cTextNormalDark),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  );
}

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: cWhite,
    useMaterial3: true,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused)) {
              return cDark;
            }
            return cTextDark;
          },
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xff1A1A1A)),
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
