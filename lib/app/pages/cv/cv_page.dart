import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/data/local/hard_code.dart';

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
                style: context.bodyText2.copyWith(color: cTextOrange),
              ),
            ],
          ),
          kHeight10,
          const Divider(),
          kHeight10,
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (_, index) => _AnimatedIcon(
                icon: HardCodeData.iconAnimationData.elementAt(index).icon,
                hintText:
                    HardCodeData.iconAnimationData.elementAt(index).hintText,
              ),
              separatorBuilder: (_, __) => kWidth10,
              itemCount: HardCodeData.iconAnimationData.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  const _AnimatedIcon({
    Key? key,
    required this.icon,
    required this.hintText,
  }) : super(key: key);
  final IconData icon;
  final String hintText;
  @override
  State<_AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<_AnimatedIcon> {
  Color bgContainerColorState = cTransparent;
  Color? bgIconColorState;
  double animatedPositedState = 0;
  bool get isHover => bgIconColorState != null;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          top: animatedPositedState,
          duration: kDuration200ml,
          child: AnimatedSwitcher(
            duration: kDuration200ml,
            child: isHover
                ? Text(
                    widget.hintText,
                    style: context.bodyText2.copyWith(color: cTextLightDark),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        MouseRegion(
          onEnter: onEnter,
          onExit: onExit,
          child: AnimatedContainer(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: cWhite,
                width: 0.5,
              ),
              shape: BoxShape.circle,
              color: bgContainerColorState,
            ),
            alignment: Alignment.center,
            duration: kDuration300ml,
            child: AnimatedSwitcher(
              duration: kDuration300ml,
              child: FaIcon(
                widget.icon,
                color: bgIconColorState,
                key: UniqueKey(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onEnter(_) {
    bgContainerColorState = cWhite;
    bgIconColorState = cDark;
    animatedPositedState = -25;
    setState(() {});
  }

  void onExit(_) {
    bgContainerColorState = cTransparent;
    bgIconColorState = null;
    animatedPositedState = 0;
    setState(() {});
  }
}
