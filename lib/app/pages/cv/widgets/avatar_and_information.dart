import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/data/local/hard_code.dart';

class AvatarAndInformation extends StatelessWidget {
  const AvatarAndInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cDarkBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox.square(
                dimension: 100,
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
              const Divider(),
              kHeight10,
              const _ListIconAnimation(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListIconAnimation extends StatelessWidget {
  const _ListIconAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, index) => _AnimatedIcon(
          icon: HardCodeData.iconAnimationData.elementAt(index).icon,
          hintText: HardCodeData.iconAnimationData.elementAt(index).hintText,
        ),
        separatorBuilder: (_, __) => kWidth10,
        itemCount: HardCodeData.iconAnimationData.length,
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

// ignore: unused_element
class _HelloWord extends StatelessWidget {
  const _HelloWord({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            'void main () { print(\'Hello, World!\'); }',
            textStyle: context.bodyText1,
            speed: kDuration200ml,
          ),
        ],
        totalRepeatCount: 4,
        pause: kDuration200ml,
        displayFullTextOnTap: true,
        stopPauseOnTap: false,
        repeatForever: true,
      ),
    );
  }
}
