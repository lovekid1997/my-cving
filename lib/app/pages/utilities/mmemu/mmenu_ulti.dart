import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/restaurant_providers.dart';
import 'package:my_cving/app/pages/utilities/mmemu/widgets/create_quickly_table.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class MMenuUtilities extends StatelessWidget {
  const MMenuUtilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _InputToken.provider(),
              kHeight20,
              const _Actions(),
              kHeight20,
              const ButtonQuickCreateTable(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputToken extends StatefulWidget {
  const _InputToken();

  static ChangeNotifierProvider<RestaurantProviders> provider() {
    return ChangeNotifierProvider(
      create: (_) => RestaurantProviders(),
      child: const _InputToken(),
    );
  }

  @override
  State<_InputToken> createState() => _InputTokenState();
}

class _InputTokenState extends State<_InputToken> {
  StreamController tokenStream = StreamController<String>();

  @override
  void initState() {
    tokenStream.stream
        .debounceTime(const Duration(milliseconds: 800))
        .listen((token) {
      RestaurantProviders.of(context).setToken(token);
      RestaurantProviders.of(context).getRestaurants();
    });
    RestaurantProviders.of(context).initShowMessage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        label: Text('Token'),
      ),
      onChanged: (value) {
        tokenStream.sink.add(value);
      },
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FilledButton(
            onPressed: () {},
            child: const Text('Tạo nhanh bàn'),
          ),
        ],
      ),
    );
  }
}
