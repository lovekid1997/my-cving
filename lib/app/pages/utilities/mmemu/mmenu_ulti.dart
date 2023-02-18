import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/create_table_providers.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/restaurant_providers.dart';
import 'package:my_cving/app/pages/utilities/mmemu/widgets/button_quick_create_table.dart';
import 'package:my_cving/app/pages/utilities/mmemu/widgets/input_token_and_show_restaurants.dart';
import 'package:my_cving/app/pages/utilities/mmemu/widgets/show_table_positions.dart';
import 'package:provider/provider.dart';

class MMenuUtilities extends StatefulWidget {
  const MMenuUtilities({super.key});
  static provider() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => TableProviders(),
        ),
      ],
      child: const MMenuUtilities(),
    );
  }

  @override
  State<MMenuUtilities> createState() => _MMenuUtilitiesState();
}

class _MMenuUtilitiesState extends State<MMenuUtilities> {
  @override
  void initState() {
    TableProviders.of(context).initShowMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: context.watch<TableProviders>().isLoading,
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
