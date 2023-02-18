import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:my_cving/app/pages/utilities/mmemu/elements/restaurants.dart';
import 'package:my_cving/app/pages/utilities/mmemu/net_work/net_work.dart';
import 'package:my_cving/app/services/logger.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class RestaurantProviders extends BaseChangeNotifier {
  static RestaurantProviders of(BuildContext context) =>
      context.read<RestaurantProviders>();
  Restaurants mmenuRestaurants = Restaurants([]);
  final NetWorkMmenu netWorkMmenu = NetWorkMmenu();
  String userId = '';
  Restaurant? selectedRestaurant;
  Future getRestaurants() async {
    try {
      final results =
          await netWorkMmenu.dio.get('/restaurants?employeeUserId=$userId');
      mmenuRestaurants = Restaurants.fromJson(results.data);
      selectedRestaurant = mmenuRestaurants.restaurants.firstOrNull;
      notifyListeners();
    } on DioError catch (e) {
      addErrorMessage(e.response?.data?.toString() ?? '');
      logger.e(e);
    }
  }

  void setToken(String token) {
    netWorkMmenu.setAuthorization(token);
    decodeJwtAndGetUserId(token);
  }

  void decodeJwtAndGetUserId(String token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    userId = payload['sub'];
  }

  void changeSelectedRestaurant(Restaurant restaurant) {
    selectedRestaurant = restaurant;
    notifyListeners();
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
