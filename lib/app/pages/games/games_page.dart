import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});
  static const String name = 'games';

  static const String path = 'games';

  static void pushPage(BuildContext context) => context.goNamed(path);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
