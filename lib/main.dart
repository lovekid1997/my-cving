import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/config/config.dart';
import 'package:my_cving/app/pages/home/home_page.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/settings/theme_providers.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupFont();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(settingsProvider);
    return MaterialApp(
      builder: (context, child) {
        return ResponsiveWrapper.builder(
          child,
          defaultScale: true,
          minWidth: 480,
          breakpoints: const [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.resize(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
        );
      },
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

