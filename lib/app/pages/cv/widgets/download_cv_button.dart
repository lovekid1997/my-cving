import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DownloadCvButton extends StatelessWidget {
  const DownloadCvButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.download),
            label: const Text(
              'DOWNLOAD CV',
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(150, 42),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: 0,
                vertical: 0,
              ),
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
            ),
          ),
        ),
      ],
    );
  }
}
