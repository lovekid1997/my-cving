import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/settings/theme_providers.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/data/local/hard_code.dart';
import 'package:my_cving/domain/entities/nav_bar.dart';
import 'package:rive/rive.dart';

class NavbarWidget extends ConsumerStatefulWidget {
  const NavbarWidget({super.key});

  static const double imageSize = 100;

  @override
  NavbarWidgetState createState() => NavbarWidgetState();
}

class NavbarWidgetState extends ConsumerState<NavbarWidget> {
  final double _heightExpand = 120;

  // animation state
  double _heightExpandState = 0;
  double _opacityState = 0;

  // selected state
  int? _selected;

  // data
  late List<Navbar> _data;

  @override
  Widget build(BuildContext context) {
    ref.watch(themesProvider);
    _data = HardCodeData.navBarData(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: kThemeChangeDuration,
        decoration: boxDecorationExpandWidget,
        child: MouseRegion(
          onExit: (_) => _onClose(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Logo(),
                        ..._data
                            .asMap()
                            .map((index, e) => MapEntry(
                                index,
                                _AnimationButtonNavbar(
                                  title: e.title,
                                  onHover: () => _onExpand(index),
                                  isSelected: _isSelected(index),
                                  isShowExpandButton:
                                      e.navbarSubEntities.isNotEmpty,
                                  onTap: e.onEvent,
                                )))
                            .values
                            .toList(),
                      ],
                    ),
                    AnimatedContainer(
                      duration: kDuration300ml,
                      height: _heightExpandState,
                      child: AnimatedOpacity(
                        duration: kDuration300ml,
                        opacity: _opacityState,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.zero,
                          child: Column(
                            children: [
                              kDivider,
                              kHeight4,
                              AnimatedSwitcher(
                                duration: kDuration300ml,
                                child: Row(
                                  key: ValueKey(_selected),
                                  children: [
                                    if (_selected == null)
                                      const SizedBox.shrink()
                                    else
                                      ..._data[_selected!]
                                          .navbarSubEntities
                                          .map(
                                            (e) => _AnimationSubButtonNavbar(
                                              onTap: () {},
                                              subNavbar: e,
                                            ),
                                          )
                                          .toList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kDivider,
            ],
          ),
        ),
      ),
    );
  }

  bool get _isExpand => _heightExpandState == _heightExpand;
  BoxDecoration get boxDecorationExpandWidget => BoxDecoration(
        color: context.colorBetweenThemeMode(
          darkModeColor: cDark,
          lightModeColor: cWhite,
        ),
        boxShadow: _isExpand
            ? [
                const BoxShadow(
                  color: Color(0xFF141414),
                  offset: Offset(0, 20),
                  blurRadius: 60,
                  spreadRadius: 20,
                )
              ]
            : null,
      );

  bool _isSelected(int index) => index == _selected;

  void _onExpand(int index) {
    if (_opacityState > 0 && _selected == index) {
      return;
    }
    if (_data[index].navbarSubEntities.isEmpty) {
      _onClose();
      return;
    }
    _selected = index;
    _heightExpandState = _heightExpand;
    _opacityState = 1;
    setState(() {});
  }

  void _onClose() {
    _selected = null;
    _heightExpandState = 0;
    _opacityState = 0;
    setState(() {});
  }
}

class _Logo extends StatefulWidget {
  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  Artboard? _riveArtboard;
  SMIInput<bool>? _walkInput;
  SMIInput<bool>? _jumpInput;

  static const String stateMachineName = 'Animate it';
  static const String walk = 'walk';
  static const String jump = 'JumpIT';

  late Timer timer;

  @override
  void initState() {
    rootBundle.load(ImageAssets.spacemenRiv).then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, stateMachineName);
        if (controller != null) {
          artboard.addController(controller);
          _walkInput = controller.findInput(walk);
          _jumpInput = controller.findInput(jump);
        }
        setState(() {
          _riveArtboard = artboard;
        });
      },
    ).then((_) {
      _walkInput?.value = true;
    });
    super.initState();
    _autoWalk();
  }

  @override
  Widget build(BuildContext context) {
    if (_riveArtboard == null) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/');
      },
      child: MouseRegion(
        onHover: (_) {
          _jumpInput?.value = true;
          _walkInput?.value = false;
        },
        child: SizedBox.square(
          dimension: NavbarWidget.imageSize,
          child: Rive(
            artboard: _riveArtboard!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _autoWalk() {
    timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (!(_walkInput?.value ?? false)) {
        _walkInput?.value = true;
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class _AnimationButtonNavbar extends StatelessWidget {
  const _AnimationButtonNavbar({
    Key? key,
    required this.title,
    required this.onHover,
    required this.isSelected,
    required this.isShowExpandButton,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final Function() onHover;
  final bool isSelected;
  final bool isShowExpandButton;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
            label: Text(title),
            onPressed: onTap,
            icon: isShowExpandButton
                ? const Icon(
                    Icons.expand_more,
                  )
                : const SizedBox.shrink(),
            onHover: (_) => onHover(),
            style: ButtonStyle(
              foregroundColor: foregroundColor(context),
              animationDuration: Duration.zero,
              textStyle: MaterialStateProperty.all(context.headlineSmall),
              backgroundColor: MaterialStateProperty.all(cTransparent),
              overlayColor: MaterialStateProperty.all(cTransparent),
            ),
          ),
        ),
      ],
    );
  }

  MaterialStateProperty<Color?>? foregroundColor(
          BuildContext context) =>
      isSelected
          ? MaterialStateProperty.all(context
              .theme.textButtonTheme.style!.foregroundColor!
              .resolve({MaterialState.hovered}))
          : null;
}

class _AnimationSubButtonNavbar extends StatefulWidget {
  const _AnimationSubButtonNavbar({
    Key? key,
    required this.onTap,
    required this.subNavbar,
  }) : super(key: key);
  final Function() onTap;
  final SubNavbar subNavbar;
  @override
  State<_AnimationSubButtonNavbar> createState() =>
      _AnimationSubButtonNavbarState();
}

class _AnimationSubButtonNavbarState extends State<_AnimationSubButtonNavbar> {
  Color? titleColor;
  Color subTitleColor = cTextDark;
  SubNavbar get subNavbar => widget.subNavbar;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onHover: highlightColor,
        onExit: offHightLightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: k4,
              ),
              child: Row(
                children: [
                  Icon(
                    subNavbar.icon,
                    color: titleColor,
                  ),
                  kWidth4,
                  Text(
                    subNavbar.title,
                    style: context.titleLarge.copyWith(color: titleColor),
                  ),
                ],
              ),
            ),
            Text(
              subNavbar.subTitle,
              style: context.titleSmall.copyWith(color: subTitleColor),
            ),
          ],
        ),
      ),
    );
  }

  void highlightColor(_) {
    if (subTitleColor == cTextNormalDark) {
      return;
    }
    titleColor = context.isDarkMode ? cTextLightDark : null;
    subTitleColor = cTextNormalDark;
    setState(() {});
  }

  void offHightLightColor(_) {
    if (subTitleColor == cTextDark) {
      return;
    }
    titleColor = null;
    subTitleColor = cTextDark;
    setState(() {});
  }
}
