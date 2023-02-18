import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/create_table_providers.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/restaurant_providers.dart';
import 'package:my_cving/app/pages/utilities/mmemu/widgets/button_quick_create_table.dart';
import 'package:my_cving/app/pages/utilities/mmemu/widgets/input_token_and_show_restaurants.dart';
import 'package:my_cving/app/pages/utilities/mmemu/widgets/show_table_positions.dart';
import 'package:provider/provider.dart';

class MMenuUtilities extends StatelessWidget {
  const MMenuUtilities({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableProviders(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: const [
                InputTokenAndShowRestaurants(),
                kHeight20,
                ShowTablePositions(),
                kHeight20,
                ButtonQuickCreateTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
