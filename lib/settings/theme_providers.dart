import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themesProvider =
    StateNotifierProvider<ThemesProvider, ThemeMode>((_) => ThemesProvider());

class ThemesProvider extends StateNotifier<ThemeMode> {
  ThemesProvider() : super(ThemeMode.dark);

  ThemeMode get themeMode => state;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  void toggleThemeMode() {
    if (themeMode == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}
