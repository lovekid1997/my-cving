import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/avatar_and_information.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/download_cv_button.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/experience_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/information_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/summary.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/app/widgets/divider.dart';
import 'package:my_cving/data/local/hard_code.dart';
import 'package:my_cving/domain/entities/skill.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  static const String name = 'cv';

  static const String path = 'cv';

  static void pushPage(BuildContext context) => context.goNamed(path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: const [
          _LeftPanel(),
          _Body(),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff1E1E27)),
        child: Column(
          children: [
            kHeight20,
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
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
                          marginRight:
                              index < HardCodeData.skills.length - 1 ? 20 : 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

class _LeftPanel extends StatelessWidget {
  const _LeftPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      color: const Color(0xff20212A),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            AvatarAndInformation(),
            kHeight10,
            ExperienceBasic(),
            InformationBasic(),
            DividerCommon(
              indent: 20,
              endIndent: 20,
            ),
            SummaryWidget(),
            DividerCommon(
              indent: 20,
              endIndent: 20,
            ),
            DownloadCvButton(),
          ],
        ),
      ),
    );
  }
}
