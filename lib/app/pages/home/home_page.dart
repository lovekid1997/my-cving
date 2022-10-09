import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/pages/home/widgets/home_body_widget.dart';
import 'package:my_cving/app/pages/home/widgets/navbar_widget.dart';
import 'package:my_cving/app/utils/context.dart';
import 'package:my_cving/app/settings/theme_providers.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Column(
        children: const [
          NavbarWidget(),
          HomeBodyWidget(),
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
              ref.read(themesProvider.notifier).toggleThemeMode();
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
