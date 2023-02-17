import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_cving/app/pages/utilities/mmemu/elements/restaurants.dart';
import 'package:my_cving/app/pages/utilities/mmemu/net_work/net_work.dart';
import 'package:my_cving/app/services/logger.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class RestaurantProviders extends BaseChangeNotifier {
  static RestaurantProviders of(BuildContext context) =>
      context.read<RestaurantProviders>();
  final Restaurants mmenu = Restaurants([]);
  final NetWorkMmenu netWorkMmenu = NetWorkMmenu();
  Future getRestaurants() async {
    try {
      final results =
          await netWorkMmenu.dio.get<Map<String, dynamic>>('/restaurants');
      final restaurants = Restaurants.fromJson(results.data ?? {});
      logger.e(restaurants);
    } on DioError catch (e) {
      addErrorMessage(e.response?.data?.toString() ?? '');
    }
  }

  void setToken(String token) {
    netWorkMmenu.setAuthorization(token);
  }
}

class BaseChangeNotifier extends ChangeNotifier {
  StreamController errorStream = StreamController<String>();
  @override
  void dispose() {
    errorStream.close();
    super.dispose();
  }

  addErrorMessage(String message) {
    errorStream.sink.add(message);
  }

  void initShowMessage(BuildContext context) {
    errorStream.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((event) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(event)));
    });
  }
}
