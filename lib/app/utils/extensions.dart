import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/config/constant.dart';
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

  Image imageNetwork({
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
      Image.network(
        this,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return ImageAssets.crying.image(
            width: width,
            height: height,
            cacheWidth: cacheWidth,
            cacheHeight: cacheHeight,
          );
        },
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
}

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextStyle get headline4 => theme.textTheme.headlineLarge!;
  TextStyle get headline5 => theme.textTheme.headlineMedium!;
  TextStyle get headline6 => theme.textTheme.headlineSmall!;
  TextStyle get headlineSmall => theme.textTheme.headlineSmall!;
  TextStyle get titleLarge => theme.textTheme.titleLarge!;
  TextStyle get titleMedium => theme.textTheme.titleMedium!;
  TextStyle get titleSmall => theme.textTheme.titleSmall!;
  TextStyle get bodyText1 => theme.textTheme.bodyLarge!;
  TextStyle get bodyText2 => theme.textTheme.bodyMedium!;
  TextStyle get caption => theme.textTheme.bodySmall!;

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
