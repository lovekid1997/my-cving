import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

class InformationBasic extends StatelessWidget {
  const InformationBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Thông tin liên hệ',
            style: context.bodyText1.copyWith(color: cTextLightDark)),
        const _Item(
          title: 'Quận 12, TPHCM',
          icon: FontAwesomeIcons.locationDot,
        ),
        kHeight8,
        const _Item(
          title: '0902 646 558',
          icon: FontAwesomeIcons.phone,
        ),
        kHeight8,
        const _Item(
          title: 'nguyenthevinh297@gmail.com',
          icon: FontAwesomeIcons.envelope,
          isOpenLink: true,
        ),
        kHeight8,
        const _Item(
          title: 'http://localhost:3000.com.vn',
          icon: FontAwesomeIcons.earthAsia,
        ),
      ],
    );
  }
}

class _Item extends StatefulWidget {
  const _Item({
    Key? key,
    required this.title,
    required this.icon,
    this.isOpenLink = false,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final bool isOpenLink;
  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> with TickerProviderStateMixin {
  late AnimationController animatinController;
  late Animation<double> animation;
  late Tween<double> tween;
  late AnimationController colorAnimationController;
  late Animation<Color?> colorAnimation;
  @override
  void initState() {
    animatinController = AnimationController(
      vsync: this,
      duration: kDuration1Seconds,
      reverseDuration: kDuration1Seconds,
    );

    tween = Tween<double>(
      begin: 0,
      end: 2,
    );

    animation = tween.animate(CurvedAnimation(
      parent: animatinController,
      curve: Curves.elasticInOut,
      reverseCurve: Curves.elasticInOut,
    ));

    animation.addListener(() {
      setState(() {});
    });

    colorAnimationController = AnimationController(
      vsync: this,
      duration: kDuration1Seconds,
      reverseDuration: kDuration1Seconds,
    );

    colorAnimation = TweenSequence([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(begin: cTextNormalDark, end: cWhite),
      ),
    ]).animate(colorAnimationController);

    animation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.completed:
          animatinController.reverse();
          colorAnimationController.reverse();
          break;
        case AnimationStatus.forward:
          colorAnimationController.forward();
          break;
        default:
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animatinController.dispose();
    super.dispose();
  }

  double get angle {
    return animation.value * math.pi;
  }

  Color? colorText;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        animatinController.forward();
        colorText = cWhite;
      },
      onExit: (_) {
        colorText = null;
      },
      child: Row(
        children: [
          Transform.rotate(
            angle: angle,
            child: FaIcon(
              widget.icon,
              color: colorAnimation.value,
            ),
          ),
          kWidth10,
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: widget.isOpenLink
                      ? context.bodyText2.copyWith(color: colorText)
                      : null,
                ),
                if (widget.isOpenLink)
                  AnimatedContainer(
                    duration: kDuration300ml,
                    height: 1,
                    color: cWhite,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
