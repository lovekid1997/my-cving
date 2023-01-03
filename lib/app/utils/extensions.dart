import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/services/theme_providers.dart';

extension StringExtension on String {
  Image image({
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) =>
      Image.asset(
        this,
        width: width,
        height: height,
        color: color,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
}

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextStyle get headline4 => theme.textTheme.headline4!;
  TextStyle get headline5 => theme.textTheme.headline5!;
  TextStyle get headline6 => theme.textTheme.headline6!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;
  TextStyle get titleLarge => theme.textTheme.titleLarge!;
  TextStyle get titleMedium => theme.textTheme.titleMedium!;
  TextStyle get titleSmall => theme.textTheme.titleSmall!;
  TextStyle get bodyText1 => theme.textTheme.bodyText1!;
  TextStyle get bodyText2 => theme.textTheme.bodyText2!;
  TextStyle get caption => theme.textTheme.caption!;

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

extension TextStyleE on TextStyle {}
