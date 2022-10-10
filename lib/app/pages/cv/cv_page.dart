import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

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
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                _AvatarAndInformation(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(),
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

class _AvatarAndInformation extends StatelessWidget {
  const _AvatarAndInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff252531),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox.square(
            dimension: 120,
            child: CircleAvatar(
              backgroundImage: ImageAssets.myImage.image().image,
            ),
          ),
          kHeight10,
          Column(
            children: [
              Text(
                'NGUYEN THE VINH',
                style: context.titleLarge.copyWith(color: cTextLightDark),
              ),
              Text(
                'A FLUTTER DEVELOPER',
                style: context.bodyText2.copyWith(color: Color(0xffAC5A1A)),
              ),
            ],
          ),
          kHeight10,
          const Divider(),
          FaIcon(FontAwesomeIcons.facebook),
        ],
      ),
    );
  }
}
