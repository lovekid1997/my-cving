import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/pages/utilities/mmemu/mmenu_ulti.dart';

class UtilitiesPage extends StatelessWidget {
  const UtilitiesPage({super.key});

  static const String name = 'utilities';

  static const String path = 'utilities';

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: FlexThemeData.dark(
        scheme: FlexScheme.deepBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        tabBarStyle: null,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      child: const MMenuUtilities(),
    );
  }

  static pushPage(BuildContext context) => context.goNamed(path);
}
