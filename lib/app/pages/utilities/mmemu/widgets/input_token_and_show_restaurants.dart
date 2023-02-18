import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/create_table_providers.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/restaurant_providers.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class InputTokenAndShowRestaurants extends StatefulWidget {
  const InputTokenAndShowRestaurants({super.key});

  @override
  State<InputTokenAndShowRestaurants> createState() =>
      _InputTokenAndShowRestaurantsState();
}

class _InputTokenAndShowRestaurantsState
    extends State<InputTokenAndShowRestaurants> {
  StreamController tokenStream = StreamController<String>();

  @override
  void initState() {
    tokenStream.stream
        .debounceTime(const Duration(milliseconds: 800))
        .listen((token) {
      RestaurantProviders.of(context).setToken(token);
      RestaurantProviders.of(context).getRestaurants().then((_) {
        TableProviders.of(context).fetchTablePosition(
            RestaurantProviders.of(context).selectedRestaurant?.id);
      });
    });
    RestaurantProviders.of(context).initShowMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            label: Text('Token'),
          ),
          onChanged: (value) {
            tokenStream.sink.add(value);
          },
        ),
        Consumer<RestaurantProviders>(
          builder: (context, value, child) {
            final data = value.mmenuRestaurants.restaurants;
            final selected = value.selectedRestaurant;
            return Row(
              children: data
                  .asMap()
                  .map(
                    (i, e) {
                      final item = data.elementAt(i);
                      final color = selected?.id == item.id
                          ? const Color(0xff3498db).withOpacity(.5)
                          : cTransparent;

                      return MapEntry(
                        i,
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: InkWell(
                              onTap: () {
                                RestaurantProviders.of(context)
                                    .changeSelectedRestaurant(item);
                                TableProviders.of(context)
                                    .fetchTablePosition(item.id);
                              },
                              child: ColoredBox(
                                color: color,
                                child: Column(
                                  children: [
                                    item.image.imageNetwork(
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                      cacheWidth: 500,
                                      cacheHeight: 500,
                                    ),
                                    kHeight10,
                                    Text(
                                      item.name,
                                      style: context.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
