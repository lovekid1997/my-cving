import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/pages/cv/cv_page.dart';
import 'package:my_cving/app/pages/doc/doc_page.dart';
import 'package:my_cving/app/pages/games/games_page.dart';
import 'package:my_cving/app/pages/home/home_page.dart';
import 'package:my_cving/app/pages/information/information_page.dart';
import 'package:my_cving/app/pages/settings/settings_page.dart';
import 'package:my_cving/app/pages/utilities/utilities_page.dart';

final GoRouter myRouter = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      name: HomePage.name,
      path: HomePage.path,
      pageBuilder: (context, state) => _pageBuilder(
        const HomePage(),
        state,
      ),
      routes: [
        GoRoute(
          name: InformationPage.name,
          path: InformationPage.path,
          builder: (BuildContext context, GoRouterState state) =>
              const InformationPage(),
          pageBuilder: (context, state) => _pageBuilder(
            const InformationPage(),
            state,
          ),
        ),
        GoRoute(
          name: SettingsPage.name,
          path: SettingsPage.path,
          pageBuilder: (context, state) =>
              _pageBuilder(const SettingsPage(), state),
        ),
        GoRoute(
          name: CvPage.name,
          path: CvPage.path,
          pageBuilder: (context, state) => _pageBuilder(const CvPage(), state),
        ),
        GoRoute(
          name: DocPage.name,
          path: DocPage.path,
          pageBuilder: (context, state) => _pageBuilder(const DocPage(), state),
        ),
        GoRoute(
          name: GamesPage.name,
          path: GamesPage.path,
          pageBuilder: (context, state) =>
              _pageBuilder(const GamesPage(), state),
        ),
        GoRoute(
          name: UtilitiesPage.name,
          path: UtilitiesPage.path,
          pageBuilder: (context, state) =>
              _pageBuilder(const UtilitiesPage(), state),
        ),
      ],
    ),
  ],
);

CustomTransitionPage _pageBuilder(Widget child, GoRouterState state) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
