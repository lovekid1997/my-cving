import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/routes/routes.dart';
import 'package:my_cving/app/settings/localizations_provider.dart';
import 'package:my_cving/app/settings/theme_providers.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themesProvider);
    final locale = ref.watch(localizationsProvider);
    return MaterialApp.router(
      title: 'My CV',
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child,
          defaultScale: false,
          minWidth: 480,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.resize(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        );
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: myRouter,
    );
  }
}
