import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cving/app/utils/widget_utils.dart';
import 'package:rive/rive.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            _Logo(),
            Text('qweqweqwewqeqweqweqweqwe'),
          ],
        ),
        kDivider,
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
  }

  @override
  Widget build(BuildContext context) {
    if (_riveArtboard == null) {
      return const SizedBox.shrink();
    }
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
          ),
        ),
      ],
    );
  }
}
