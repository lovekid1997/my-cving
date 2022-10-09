import 'package:flutter/material.dart';
import 'package:my_cving/app/utils/context.dart';
import 'package:my_cving/domain/entities/nav_bar.dart';

class HardCodeData {
  static List<Navbar> navBarData(BuildContext context) => _navBarData(context);
}

List<Navbar> _navBarData(BuildContext context) {
  final localizations = context.localizations;
  return [
    Navbar(
      localizations.introduce,
      [
        SubNavbar(
          title: 'Hồ sơ',
          subTitle: '''Vinh Nguyễn Thế
Flutter developer at Mmenu
Quận 12, Ho Chi Minh City, Vietnam''',
          icon: Icons.person,
        ),
      ],
    ),
    Navbar(
      localizations.project,
      [
        SubNavbar(
          title: 'Dự án cá nhân',
          subTitle: '''My cv - link: mycving.com
Mmenu - link: 
Palazzo - link: ''',
          icon: Icons.person,
        ),
      ],
    ),
    Navbar(
      localizations.cv,
      [],
    ),
    Navbar(
      localizations.docs,
      [],
    ),
    Navbar(
      localizations.utilities,
      [],
    ),
    Navbar(
      localizations.games,
      [],
    ),
  ];
}
