import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cving/app/pages/cv/cv_page.dart';
import 'package:my_cving/app/pages/doc/doc_page.dart';
import 'package:my_cving/app/pages/games/games_page.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/domain/entities/experience.dart';
import 'package:my_cving/domain/entities/icon_animation.dart';
import 'package:my_cving/domain/entities/nav_bar.dart';
import 'package:my_cving/domain/entities/skill.dart';

class HardCodeData {
  static List<Navbar> navBarData(BuildContext context) => _navBarData(context);
  static List<IconAnimation> iconAnimationData = _iconAnimation;
  static List<List<Skill>> skills = _skills;
  static List<Experience> experience = Experience.instance();
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
      () => DocPage.pushPage(context),
    ),
    Navbar(
      localizations.utilities,
      [],
      () {},
    ),
    Navbar(
      localizations.games,
      [],
      () => GamesPage.pushPage(context),
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
    'Blogs',
    FontAwesomeIcons.wordpress,
  ),
];

final List<List<Skill>> _skills = [
  [
    Skill(
      'PROGRAMMING LANGUAGES',
      [
        'Dart',
        'Kotlin - Basic',
        'Swift - Basic',
      ],
    ),
    Skill(
      'FRAMEWORKS & PLATFORMS',
      [
        'Flutter',
        'Android - Basic',
        'Ios - Basic',
      ],
    ),
  ],
  [
    Skill(
      'DATABASE',
      [
        'SQL',
        'FireStore',
        'Hive - Flutter',
      ],
    ),
    Skill(
      'VERSION CONTROL',
      [
        'Git (Git Lab & Github)',
      ],
    ),
    Skill(
      'IDE',
      [
        'Visual Studio Code',
        'Android studio',
      ],
    ),
  ],
  [
    Skill(
      'KNOWLEDGE',
      [
        'Understanding about OOP, Design Pattern, SOLID principles, Dependency Injection, ...',
        'Understanding about TDD, Integration testing,...',
        'Good understanding about the Agile and Scrum process',
        'Good understanding software design, database design, RestfulAPI, ...',
        'Good time management, presentation and teamwork skills ...',
      ],
    ),
  ],
];
