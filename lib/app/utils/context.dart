import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/settings/theme_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  TextStyle get headline5 => Theme.of(this).textTheme.headline5!;
  TextStyle get headline6 => Theme.of(this).textTheme.headline6!;
  TextStyle get headlineSmall => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode =>
      ProviderScope.containerOf(this, listen: false).read(themesProvider) ==
      ThemeMode.dark;

  // localization
  AppLocalizations get localizations => AppLocalizations.of(this);
}
