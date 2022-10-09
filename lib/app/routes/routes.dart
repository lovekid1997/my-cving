import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/pages/home/home_page.dart';
import 'package:my_cving/app/pages/information/information_page.dart';
import 'package:my_cving/app/pages/settings/settings_page.dart';

final GoRouter myRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: HomePage.path,
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
    GoRoute(
      path: InformationPage.path,
      builder: (BuildContext context, GoRouterState state) =>
          const InformationPage(),
    ),
    GoRoute(
      path: SettingsPage.path,
      builder: (BuildContext context, GoRouterState state) =>
          const SettingsPage(),
    ),
  ],
);
