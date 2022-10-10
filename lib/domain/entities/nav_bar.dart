import 'package:flutter/material.dart';

class Navbar {
  final String title;
  final List<SubNavbar> navbarSubEntities;
  final VoidCallback onEvent;
  Navbar(this.title, this.navbarSubEntities, this.onEvent);
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
