import 'package:flutter/material.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...List.generate(
            200,
            (index) => Text('qwe$index'),
          ),
        ],
      ),
    );
  }
}
