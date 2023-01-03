import 'package:flutter/material.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: cDarkBlue,
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Kinh nghiệm',
            style: context.headline6.copyWith(color: cWhite),
          ),
        ),
      ],
    );
  }
}
