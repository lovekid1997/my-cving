import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/data/local/hard_code.dart';
import 'package:my_cving/domain/entities/skill.dart';

class SkilsWidget extends StatelessWidget {
  const SkilsWidget({
    Key? key,
  }) : super(key: key);

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
            'Kĩ năng',
            style: context.headline6.copyWith(color: cWhite),
          ),
        ),
        kHeight10,
        IntrinsicHeight(
          child: Row(
            children: List.generate(
              HardCodeData.skills.length,
              (index) => _Card(
                skills: HardCodeData.skills.elementAt(index),
                marginRight: index < HardCodeData.skills.length - 1 ? 20 : 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.skills,
    required this.marginRight,
  }) : super(key: key);
  final List<Skill> skills;
  final double marginRight;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: cDarkBlue,
        ),
        margin: EdgeInsets.only(right: marginRight),
        padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            skills.length,
            (index) {
              final skill = skills.elementAt(index);
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.title,
                      style: context.headline6.copyWith(color: cWhite1),
                    ),
                    kHeight4,
                    ...List.generate(
                      skill.contents.length,
                      (index) => Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: const BoxDecoration(
                              color: cTextLight,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              skill.contents.elementAt(index),
                              style: context.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
