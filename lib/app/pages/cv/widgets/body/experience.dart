import 'package:flutter/material.dart';
import 'package:my_cving/app/services/url_launcher.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/link.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: cDarkBlue,
          width: double.infinity,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Kinh nghiệm',
            style: context.headline6.copyWith(color: cWhite),
          ),
        ),
        FixedTimeline.tileBuilder(
          builder: TimelineTileBuilder.connected(
            connectorBuilder: (_, index, type) {
              return const SizedBox(
                height: 60.0,
                child: SolidLineConnector(),
              );
            },
            oppositeContentsBuilder: (_, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mmenu',
                    style: context.titleMedium.copyWith(color: cTextLight1Dark),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'FUTTER DEVELOPER',
                    style: context.caption.copyWith(color: cTextNormalDark),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
            contentsBuilder: _ProjectDesciption.contentsBuilder,
            nodePositionBuilder: (_, index) {
              return .12;
            },
            indicatorBuilder: (_, index) {
              return DotIndicator(
                size: 130,
                border: Border.all(
                  color: cDarkBlue,
                  width: 2,
                ),
                color: cDark,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '08/2021',
                      style: context.headline6.copyWith(
                        color: cTextLight1Dark,
                      ),
                    ),
                    Text(
                      '-',
                      style: context.headline6.copyWith(
                        color: cTextLight1Dark,
                      ),
                    ),
                    Text(
                      'Đến nay',
                      style: context.headline6.copyWith(
                        color: cTextLight1Dark,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    );
  }
}

class _ProjectDesciption extends StatelessWidget {
  const _ProjectDesciption();

  static Widget? contentsBuilder(BuildContext context, int index) {
    return const _ProjectDesciption();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textRich(
            context,
            'Project',
            'Mmenu admin - Mmenu customer Application',
          ),
          textRich(
            context,
            'Project Description',
            'All in one solution in the business of F&B',
          ),
          textRich(
            context,
            'Team Size',
            '8',
          ),
          textRich(
            context,
            'Responsiblities',
            'Review code, management App store and Play store, develop the frameworks and modules of the system. ',
          ),
          textRich(
            context,
            'Accomplishments',
            'Xây dựng và quản lý máy in ESC/POS. Improved teamwork and communication skills.',
          ),
          textRich(
            context,
            'Stores',
            'https://apps.apple.com/vn/app/mmenu-admin/id1610048415*https://play.google.com/store/apps/details?id=admin.mmenu.io',
          ),
          textRich(
            context,
            'Technologies',
            'Front-end: Flutter + Bloc pattern, Firebase, Protobuf, Rest API, Kotlin',
          ),
        ],
      ),
    );
  }

  Text textRich(
    BuildContext context,
    String title,
    String subTitles,
  ) {
    final subTitleWithSplit = subTitles.split('*');
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title:   ',
            style: context.bodyText2.copyWith(color: cTextNormalDark),
          ),
          ...List.generate(
            subTitleWithSplit.length,
            (index) {
              final subTitle = subTitleWithSplit.elementAt(index);
              final isLink = subTitle.contains('http');
              return [
                if (isLink) TextSpan(text: '\n', style: context.bodyText1),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: isLink
                      ? Link(
                          uri: Uri.parse(subTitle),
                          builder: (context, followLink) {
                            return GestureDetector(
                              onTap: () {
                                if (isLink) {
                                  UrlLauncher().launchUrlNewTab(subTitle);
                                }
                              },
                              child: Text(
                                '- $subTitle',
                                style: context.bodyText1.copyWith(
                                  color: cTextLight1Dark,
                                ),
                              ),
                            );
                          },
                        )
                      : Text(
                          subTitle,
                          style: context.bodyText1.copyWith(
                            color: cTextLight1Dark,
                          ),
                        ),
                )
              ];
            },
          ).expand((e) => e),
        ],
      ),
    );
  }
}
