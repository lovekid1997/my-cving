import 'package:flutter/material.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

class ExperienceBasic extends StatelessWidget {
  const ExperienceBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _AnimationItemWidget(
          title: '1,5+',
          subTitle: 'Years Experience',
        ),
        kWidth10,
        _AnimationItemWidget(
          title: '4+',
          subTitle: 'Project',
        ),
        kWidth10,
        _AnimationItemWidget(
          title: '2',
          subTitle: 'Customers',
        ),
      ],
    );
  }
}

class _AnimationItemWidget extends StatelessWidget {
  const _AnimationItemWidget({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: cDarkBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.fromLTRB(k10, k4, 0, k4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.headline4,
            ),
            Text(
              subTitle,
            ),
          ],
        ),
      ),
    );
  }
}
