import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/cv/widgets/avatar_and_information.dart';
import 'package:my_cving/app/pages/cv/widgets/download_cv_button.dart';
import 'package:my_cving/app/pages/cv/widgets/experience_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/information_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/summary.dart';
import 'package:my_cving/app/widgets/divider.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  static const String name = 'cv';

  static const String path = 'cv';

  static void pushPage(BuildContext context) => context.goNamed(path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 420,
            padding: const EdgeInsets.all(20),
            color: const Color(0xff20212A),
            child: ListView(
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
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xff1E1E27)),
              child: Column(
                children: const [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
