import 'package:flutter/material.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

class ExperienceBasic extends StatelessWidget {
  const ExperienceBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _AnimationItemWidget(
          titleAsDouble: 1.5,
          subTitle: 'Years Experience',
          symbol: '+',
        ),
        kWidth10,
        _AnimationItemWidget(
          titleAsDouble: 4.0,
          subTitle: 'Project',
          symbol: '+',
        ),
        kWidth10,
        _AnimationItemWidget(
          titleAsDouble: 2.0,
          subTitle: 'Customers',
          symbol: '',
        ),
      ],
    );
  }
}

class _AnimationItemWidget extends StatefulWidget {
  const _AnimationItemWidget({
    Key? key,
    required this.titleAsDouble,
    required this.subTitle,
    required this.symbol,
  }) : super(key: key);
  final double titleAsDouble;
  final String subTitle;
  final String symbol;
  @override
  State<_AnimationItemWidget> createState() => _AnimationItemWidgetState();
}

class _AnimationItemWidgetState extends State<_AnimationItemWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  late AnimationController boucingController;
  late Animation<double> bouncingAnimation;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: kDuration1Seconds,
    );
    animation = Tween<double>(begin: 0, end: widget.titleAsDouble).animate(
        CurvedAnimation(parent: animationController, curve: Curves.decelerate));
    animationController.forward();

    boucingController = AnimationController(
      vsync: this,
      duration: kDuration200ml,
    );
    bouncingAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(
      CurvedAnimation(
        parent: boucingController,
        curve: Curves.easeInOut,
      ),
    );
    bouncingAnimation.addListener(() {
      setState(() {});
    });
    bouncingAnimation.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.completed:
          boucingController.reverse();
          break;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    boucingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        onEnter: onEnter,
        child: ScaleTransition(
          scale: bouncingAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: cDarkBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.fromLTRB(k10, k4, 0, k4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Text(
                      '${animation.value.toStringAsFixed(1)}${widget.symbol}',
                      style: context.headline4.copyWith(color: cTextOrange),
                    );
                  },
                ),
                Text(
                  widget.subTitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onEnter(_) {
    boucingController.forward();
  }
}
