import 'package:flutter/material.dart';
import 'package:my_cving/app/pages/home/widgets/navbar_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: NavbarWidget.imageSize + 1,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: const [],
      ),
    );
  }
}
