import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/pages/information/information_page.dart';
import 'package:my_cving/app/pages/settings/settings_page.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 101,
      child: ListView(
        children: [
          TextButton(
            onPressed: () {
              context.goNamed(InformationPage.name);
            },
            child: const Text('Push information page'),
          ),
          TextButton(
            onPressed: () {
              context.goNamed(SettingsPage.name);
            },
            child: const Text('Push settings page'),
          ),
        ],
      ),
    );
  }
}
