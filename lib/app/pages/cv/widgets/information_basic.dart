import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/services/url_launcher.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:url_launcher/link.dart';

class InformationBasic extends StatelessWidget {
  const InformationBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(k12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin cơ bản',
            style: context.headline6.copyWith(color: cTextOrange),
          ),
          kHeight8,
          const _Item(
            content: '29/09/1997',
            icon: FontAwesomeIcons.cakeCandles,
            title: 'Ngày sinh',
          ),
          kHeight8,
          const _Item(
            content: 'Quận 12, TPHCM',
            icon: FontAwesomeIcons.locationDot,
            title: 'Địa chỉ',
          ),
          kHeight8,
          const _Item(
            content: '0902 646 558',
            icon: FontAwesomeIcons.phone,
            title: 'SĐT',
          ),
          kHeight8,
          _Item(
            content: 'nguyenthevinh297@gmail.com',
            icon: FontAwesomeIcons.envelope,
            onTap: openMail,
            title: 'Email',
            isMail: true,
          ),
          kHeight8,
          _Item(
            content: 'http://localhost:3000',
            icon: FontAwesomeIcons.earthAsia,
            onTap: openMyBrowser,
            isOpenLink: true,
            title: 'Website',
          ),
        ],
      ),
    );
  }

  Future<void> openMyBrowser() async {
    await UrlLauncher().launchUrlNewTab('http://localhost:3000');
  }

  Future<void> openMail() async {
    await UrlLauncher().launchMail('nguyenthevinh297@gmail.com');
  }
}

class _Item extends StatefulWidget {
  const _Item({
    Key? key,
    required this.content,
    required this.icon,
    this.isOpenLink = false,
    this.onTap,
    required this.title,
    this.isMail = false,
  }) : super(key: key);

  final String content;
  final IconData icon;
  final bool isOpenLink;
  final Function()? onTap;
  final String title;
  final bool isMail;

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
    final itemWidget = GestureDetector(
      onTap: () => widget.onTap?.call(),
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          SizedBox.square(
            dimension: 22,
            child: Center(
              child: Transform.rotate(
                angle: angle,
                child: FaIcon(
                  widget.icon,
                  color: colorAnimation.value,
                  size: 20,
                ),
              ),
            ),
          ),
          kWidth6,
          Text('${widget.title}: ',
              style: context.bodyText2.copyWith(color: colorText)),
          const Spacer(),
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.content,
                  style: context.bodyText2.copyWith(color: colorText),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
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

    Widget? child;

    if (widget.isOpenLink) {
      child ??= Link(
        uri: Uri.parse(widget.content),
        builder: (_, __) {
          return itemWidget;
        },
      );
    }
    return MouseRegion(
      onEnter: (_) {
        animatinController.forward();
        changeColorOnEnter();
      },
      onExit: (_) {
        changeColorOnExit();
      },
      child: child ?? itemWidget,
    );
  }

  void changeColorOnEnter() {
    if (widget.isOpenLink || widget.isMail) {
      colorText = cWhite;
    }
  }

  void changeColorOnExit() {
    colorText = null;
  }
}
