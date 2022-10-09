import 'package:flutter/material.dart';

// extension
extension WidgetExtensions on Widget {
  Widget get colorDebug => Container(
        color: Colors.amberAccent,
        child: this,
      );
}
