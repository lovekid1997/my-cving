import 'package:flutter/material.dart';

const kDivider = Divider(
  height: 1,
  thickness: 1,
);

class DividerCommon extends Divider {
  const DividerCommon({
    super.key,
    double height = 1,
    double thickness = 1,
    double? indent,
    double? endIndent,
    Color? color,
  }) : super(
          height: height,
          thickness: thickness,
          indent: indent,
          endIndent: endIndent,
          color: color,
        );
}
