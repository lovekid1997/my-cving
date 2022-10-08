import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/pages/home/widgets/home_body_widget.dart';
import 'package:my_cving/app/pages/home/widgets/navbar_widget.dart';
import 'package:my_cving/settings/theme_providers.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(settingsProvider.notifier).toggleThemeMode();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.swipe),
      ),
    );
  }
}


