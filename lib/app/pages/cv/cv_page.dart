import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_cving/app/constant/constant.dart';
import 'package:my_cving/app/pages/cv/avatar_and_information.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

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
            decoration: const BoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                AvatarAndInformation(),
                kHeight10,
                SummaryWidget(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(),
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
        color: const Color(0xff252531),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text('Tóm tắt', style: context.bodyText1.copyWith(color: cWhite)),
          const Text(
              'Tự học Flutter ở 1 năm cuối đại học (2020) để hoàn thành khóa luận.'),
          const Text(
              'Tham gia 1 công ty outsource với vị trí Fresher Flutter Developer trong 6 tháng.'),
          const Text(
              'Hiện tại đang tham gia thực hiện 1 dự án Product chuyên về F&B.'),
          const Text(
              'Tôi thích giúp đỡ người khác và làm việc tốt với nhóm. Tôi cũng có thể thực hiện một số nhiệm vụ cố vấn và đánh giá mã cho các thành viên khác'),
          const Text(
              'Những cuốn sách yêu thích của tôi là: Dive Into DESIGN PATTERNS.'),
        ],
      ),
    );
  }
}
