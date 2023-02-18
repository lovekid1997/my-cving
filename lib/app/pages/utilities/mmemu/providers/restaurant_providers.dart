import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:my_cving/app/pages/utilities/mmemu/elements/restaurants.dart';
import 'package:my_cving/app/pages/utilities/mmemu/net_work/net_work.dart';
import 'package:my_cving/app/services/logger.dart';
import 'package:my_cving/app/utils/extensions.dart';
import 'package:my_cving/app/utils/theme.dart';
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
      addErrorMessage(e);
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
  StreamController successSream = StreamController<String>();
  @override
  void dispose() {
    errorStream.close();
    successSream.close();
    super.dispose();
  }

  addErrorMessage(DioError e) {
    errorStream.sink.add(e.response?.data?.toString() ?? '');
  }

  addErrorMessageWithString(String e) {
    errorStream.sink.add(e);
  }

  addSuccessMessage(String message) {
    successSream.sink.add(message);
  }

  void initShowMessage(BuildContext context) {
    errorStream.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            event,
            style: context.titleMedium.copyWith(color: cWhite),
          ),
          duration: const Duration(seconds: 5),
          showCloseIcon: true,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20,
          ),
          backgroundColor: const Color(0xffe74c3c),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
    successSream.stream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            event,
            style: context.titleMedium.copyWith(color: cWhite),
          ),
          duration: const Duration(seconds: 5),
          showCloseIcon: true,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            right: 20,
            left: 20,
          ),
          backgroundColor: const Color(0xff3498db),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }
}
