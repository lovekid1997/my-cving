import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/cv/widgets/avatar_and_information.dart';
import 'package:my_cving/app/pages/cv/widgets/experience_basic.dart';
import 'package:my_cving/app/pages/cv/widgets/information_basic.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:my_cving/app/widgets/divider.dart';
import 'package:url_launcher/link.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  static const String name = 'cv';

  static const String path = 'cv';

  static void pushPage(BuildContext context) => context.goNamed(path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 420,
            padding: const EdgeInsets.all(20),
            color: const Color(0xff20212A),
            child: ListView(
              children: const [
                AvatarAndInformation(),
                kHeight10,
                ExperienceBasic(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: k14),
                  child: InformationBasic(),
                ),
                DividerCommon(
                  indent: 20,
                  endIndent: 20,
                ),

                // SummaryWidget(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Color(0xff1E1E27)),
              child: Column(
                children: const [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cDarkBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text('Tóm tắt', style: context.bodyText1.copyWith(color: cWhite)),
          const Text('''
Tự học Flutter ở năm cuối đại học (2020) để hoàn thành khóa luận.
Tham gia 1 công ty outsource với vị trí Fresher Flutter Developer trong 6 tháng.
Hiện tại đang tham gia thực hiện 1 dự án Product chuyên về F&B.
Tôi thích giúp đỡ người khác và làm việc tốt với nhóm. Tôi cũng có thể thực hiện một số nhiệm vụ cố vấn và đánh giá mã cho các thành viên khác.
Những cuốn sách yêu thích của tôi là: Dive Into DESIGN PATTERNS.
              '''),
        ],
      ),
    );
  }
}
