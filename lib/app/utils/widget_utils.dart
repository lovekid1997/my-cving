import 'package:flutter/material.dart';

// widget const
const kDivider = Divider(
  height: 1,
  thickness: 1,
);

const kHeight2 = SizedBox(height: 2);
const kHeight4 = SizedBox(height: 4);
const kHeight6 = SizedBox(height: 6);
const kWidth4 = SizedBox(width: 4);
const k8 = 8.0;
const k4 = 4.0;
const kDuration300ml = Duration(milliseconds: 300);
const kDuration500ml = Duration(milliseconds: 500);

// extension
extension WidgetExtensions on Widget {
  Widget get colorDebug => Container(
        color: Colors.amberAccent,
        child: this,
      );
}
