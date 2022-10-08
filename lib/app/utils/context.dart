import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextStyle get headline5 => Theme.of(this).textTheme.headline5!;
  TextStyle get headline6 => Theme.of(this).textTheme.headline6!;
}
