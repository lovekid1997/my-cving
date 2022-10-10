import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  static const String name = 'cv';

  static const String path = 'cv';

  static void pushPage(BuildContext context) => context.goNamed(path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('CV page')),
    );
  }
}
