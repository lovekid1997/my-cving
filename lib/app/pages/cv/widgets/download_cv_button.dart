import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/services/url_launcher.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

class DownloadCvButton extends StatelessWidget {
  const DownloadCvButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: k12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: ElevatedButton.icon(
              onPressed: () {
                UrlLauncher().launchUrlNewTab(
                    '/assets/files/NGUYEN-THE-VINH-TopCV.vn-211022.231944.pdf');
              },
              icon: const Icon(
                FontAwesomeIcons.download,
                color: cTextNormalDark,
              ),
              label: Text(
                'DOWNLOAD CV',
                style: context.bodyText2,
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
      ),
    );
  }
}
