import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/pages/home/widgets/home_body_widget.dart';
import 'package:my_cving/app/pages/home/widgets/navbar_widget.dart';
import 'package:my_cving/app/settings/localizations_provider.dart';
import 'package:my_cving/app/settings/theme_providers.dart';
import 'package:my_cving/app/utils/context.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const String path = '/';
  static const String name = 'home';
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: const [
          HomeBodyWidget(),
          NavbarWidget(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              ref.read(themesProvider.notifier).toggleThemeMode();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.localizations.changeTheme),
                    const Icon(Icons.swipe),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              const locales = AppLocalizations.supportedLocales;
              final currentLocales = ref.read(localizationsProvider);
              ref.read(localizationsProvider.notifier).state =
                  locales.firstWhere((locale) => locale != currentLocales);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.localizations.changeLocalization),
                    const Icon(Icons.swipe),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
