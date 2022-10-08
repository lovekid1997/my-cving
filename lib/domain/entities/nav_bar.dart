import 'package:flutter/material.dart';

class Navbar {
  final String title;
  final List<SubNavbar> navbarSubEntities;

  Navbar(this.title, this.navbarSubEntities);
}

class SubNavbar {
  final String title;
  final String subTitle;
  final IconData icon;

  SubNavbar({
    required this.title,
    required this.subTitle,
    required this.icon,
  });
}
