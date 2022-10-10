import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/settings/theme_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextStyle get headline5 => theme.textTheme.headline5!;
  TextStyle get headline6 => theme.textTheme.headline6!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;
  TextStyle get titleLarge => theme.textTheme.titleLarge!;
  TextStyle get titleSmall => theme.textTheme.titleSmall!;

  bool get isDarkMode =>
      ProviderScope.containerOf(this, listen: false).read(themesProvider) ==
      ThemeMode.dark;

  // localization
  AppLocalizations get localizations => AppLocalizations.of(this);

  Color colorBetweenThemeMode({
    required Color darkModeColor,
    required Color lightModeColor,
  }) {
    if (isDarkMode) {
      return darkModeColor;
    }
    return lightModeColor;
  }
}
