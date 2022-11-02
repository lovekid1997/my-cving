import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/cv/widgets/body/gridview_animation.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/avatar_and_information.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/download_cv_button.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/experience_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/information_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/summary.dart';
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
            TextButton(
                onPressed: () {
                  setState(() {});
                },
                child: const Text('test')),
            GridViewAnimation(key: UniqueKey()),
          ],
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
