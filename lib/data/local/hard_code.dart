import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cving/app/pages/cv/cv_page.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/domain/entities/icon_animation.dart';
import 'package:my_cving/domain/entities/nav_bar.dart';

class HardCodeData {
  static List<Navbar> navBarData(BuildContext context) => _navBarData(context);
  static List<IconAnimation> iconAnimationData = _iconAnimation;
}

List<Navbar> _navBarData(BuildContext context) {
  final localizations = context.localizations;
  return [
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
      () {},
    ),
    Navbar(
      localizations.cv,
      [],
      () => CvPage.pushPage(context),
    ),
    Navbar(
      localizations.docs,
      [],
      () {},
    ),
    Navbar(
      localizations.utilities,
      [],
      () {},
    ),
    Navbar(
      localizations.games,
      [],
      () {},
    ),
  ];
}

final List<IconAnimation> _iconAnimation = [
  IconAnimation(
    'Linkedin',
    FontAwesomeIcons.linkedinIn,
  ),
  IconAnimation(
    'Facebook',
    FontAwesomeIcons.facebookF,
  ),
  IconAnimation(
    'Github',
    FontAwesomeIcons.githubAlt,
  ),
  IconAnimation(
    'Github',
    FontAwesomeIcons.wordpress,
  ),
];
