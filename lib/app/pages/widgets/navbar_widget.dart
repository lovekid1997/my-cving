import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
import 'package:my_cving/app/utils/context.dart';
import 'package:my_cving/app/utils/theme.dart';
=======
>>>>>>> db71ce9ca3983adf9e22346cc5bc0d72efc7fea3
import 'package:my_cving/app/utils/widget_utils.dart';
import 'package:rive/rive.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
<<<<<<< HEAD
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _Logo(),
            _ButtonAnimation(title: 'Giới thiệu'),
            _ButtonAnimation(title: "Dự án"),
            _ButtonAnimation(title: "CV"),
            _ButtonAnimation(title: "Tài liệu"),
            _ButtonAnimation(title: "Trò chơi"),
          ],
        ),
        kDivider,
      ],
    );
  }
}

class _ButtonAnimation extends StatefulWidget {
  const _ButtonAnimation({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<_ButtonAnimation> createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<_ButtonAnimation> {
  double height = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
            label: Text(widget.title),
            onPressed: () {},
            icon: const Icon(
              Icons.expand_more,
            ),
            onHover: (val) {
              if (val) {
                setState(() {
                  height = 300;
                });
              } else {
                setState(() {
                  height = 0;
                });
              }
            },
            style: ButtonStyle(
              animationDuration: Duration.zero,
              foregroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.focused)) {
                    return cLightDart;
                  }
                  return null;
                },
              ),
              textStyle: MaterialStateProperty.all(context.headline6),
              backgroundColor: MaterialStateProperty.all(cTransparent),
              overlayColor: MaterialStateProperty.all(cTransparent),
            ),
          ),
        ),
        AnimatedContainer(
          duration: kDuration500ml,
          height: height,
        ),
=======
          children: const [
            _Logo(),
            Text('qweqweqwewqeqweqweqweqwe'),
          ],
        ),
        kDivider,
>>>>>>> db71ce9ca3983adf9e22346cc5bc0d72efc7fea3
      ],
    );
  }
}

class _Logo extends StatefulWidget {
  const _Logo();

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
    rootBundle.load('assets/logo/spaceman.riv').then(
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
<<<<<<< HEAD
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
          dimension: 120,
          child: Rive(
            artboard: _riveArtboard!,
            fit: BoxFit.cover,
=======
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/');
          },
          child: MouseRegion(
            onHover: (_) {
              _jumpInput?.value = true;
              _walkInput?.value = !(_walkInput?.value ?? false);
            },
            child: SizedBox.square(
              dimension: 80,
              child: Rive(artboard: _riveArtboard!),
            ),
>>>>>>> db71ce9ca3983adf9e22346cc5bc0d72efc7fea3
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
