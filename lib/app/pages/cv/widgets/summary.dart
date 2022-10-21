import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';

class SummaryWidget extends StatefulWidget {
  const SummaryWidget({super.key});

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  TextStyle? _textStyle;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onEnter(context),
      onExit: onExit,
      child: Padding(
        padding: const EdgeInsets.all(k12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Giới thiệu',
              style: context.headline6.copyWith(color: cTextOrange),
            ),
            kHeight8,
            AnimatedDefaultTextStyle(
              style: _textStyle ?? context.bodyText2,
              duration: kDuration300ml,
              child: const Text(
                '''
Tự học Flutter ở năm cuối đại học (2020).
Tham gia công ty outsource trong 6 tháng.
Hiện tại đang tham gia thực hiện 1 dự án Product chuyên về F&B.
Tôi thích giúp đỡ người khác và làm việc tốt với nhóm. 
Tôi cũng có thể thực hiện một số nhiệm vụ cố vấn và đánh giá mã cho các thành viên khác.
Những cuốn sách yêu thích của tôi là: Dive Into DESIGN PATTERNS.''',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onEnter(BuildContext context) {
    setState(() {
      _textStyle = context.bodyText2.copyWith(
        color: cTextLightDark,
      );
    });
  }

  void onExit(_) {
    setState(() {
      _textStyle = null;
    });
  }
}
