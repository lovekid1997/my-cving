import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grid_animation/grid_animation.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/avatar_and_information.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/download_cv_button.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/experience_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/information_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/left_panel/summary.dart';
import 'package:my_cving/app/utils/theme.dart';
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
  final GridViewAnimationController controller = GridViewAnimationController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff1E1E27)),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    controller.cancel();
                  },
                  child: const Text('cancel'),
                ),
                TextButton(
                  onPressed: () {
                    controller.deal();
                  },
                  child: const Text('deal'),
                ),
                TextButton(
                  onPressed: () {
                    controller.refresh();
                  },
                  child: const Text('refresh'),
                ),
              ],
            ),
            Expanded(
              child: GridViewAnimation(
                key: UniqueKey(),
                controller: controller,
                delayPerItem: true,
                fadeAnimation: false,
                initialFadeAnimation: true,
                delegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children: const [
                  _Card(),
                  _Card(),
                  _Card(),
                  _Card(),
                  _Card(),
                  _Card(),
                  _Card(),
                  _Card(),
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
  const _Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cTextLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cWhite),
        image: const DecorationImage(
          image: AssetImage(
            ImageAssets.riderWaite,
          ),
          fit: BoxFit.cover,
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
