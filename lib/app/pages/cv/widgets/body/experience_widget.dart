import 'package:flutter/material.dart';
import 'package:my_cving/app/services/url_launcher.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/data/local/hard_code.dart';
import 'package:my_cving/domain/entities/experience.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/link.dart';

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = HardCodeData.experience;
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
                height: 80.0,
                child: SolidLineConnector(),
              );
            },
            oppositeContentsBuilder: (_, index) {
              final item = data.elementAt(index);
              return _CompanyAndPosition(item: item);
            },
            contentsBuilder: (_, index) => _ProjectDesciption.contentsBuilder(
                experienceDescription:
                    data.elementAt(index).experienceDescription),
            nodePositionBuilder: (_, index) {
              return .12;
            },
            indicatorBuilder: (_, index) {
              final item = data.elementAt(index);
              return _FromAndToInWork(item: item);
            },
            itemCount: data.length,
          ),
        ),
      ],
    );
  }
}

class _FromAndToInWork extends StatelessWidget {
  const _FromAndToInWork({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Experience item;

  @override
  Widget build(BuildContext context) {
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
            item.from,
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
            item.to,
            style: context.headline6.copyWith(
              color: cTextLight1Dark,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyAndPosition extends StatelessWidget {
  const _CompanyAndPosition({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Experience item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          item.company,
          style: context.titleMedium.copyWith(color: cTextLight1Dark),
          textAlign: TextAlign.center,
        ),
        Text(
          item.position,
          style: context.caption.copyWith(color: cTextNormalDark),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ProjectDesciption extends StatelessWidget {
  const _ProjectDesciption(this.experienceDescription);
  final ExperienceDescription experienceDescription;

  static Widget? contentsBuilder(
          {required ExperienceDescription experienceDescription}) =>
      _ProjectDesciption(
        experienceDescription,
      );

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
            experienceDescription.project,
          ),
          textRich(
            context,
            'Project Description',
            experienceDescription.description,
          ),
          textRich(
            context,
            'Team Size',
            experienceDescription.teamSize,
          ),
          textRich(
            context,
            'Responsiblities',
            experienceDescription.responsiblities,
          ),
          textRich(
            context,
            'Accomplishments',
            experienceDescription.accomplishments,
          ),
          textRich(
            context,
            'Stores',
            experienceDescription.stores.join('*'),
          ),
          textRich(
            context,
            'Technologies',
            experienceDescription.tech,
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
