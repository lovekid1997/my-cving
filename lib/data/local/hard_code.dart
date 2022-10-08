import 'package:flutter/material.dart';
import 'package:my_cving/domain/entities/nav_bar.dart';

class HardCodeData {
  static final navBarData = _navBarData;
}

final _navBarData = [
  Navbar(
    'Giới thiệu',
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
    'Dự án',
    [],
  ),
  Navbar(
    'CV',
    [],
  ),
  Navbar(
    'Tài liệu',
    [],
  ),
  Navbar(
    'Trò chơi',
    [],
  ),
];
