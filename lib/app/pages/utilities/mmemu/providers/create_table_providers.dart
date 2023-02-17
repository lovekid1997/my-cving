import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/net_work/net_work.dart';
import 'package:my_cving/app/services/logger.dart';

class CreateTableProgress extends ChangeNotifier {
  double progress = 0;
  double _count = 1;
  createTable(List<String> generated, String restaurantId) async {
    for (var name in generated) {
      final result = await _createTable(name, '62a82f3e534ee994fd065f0d');
      if (result) {
        progress = _count * 100 / generated.length;
        _count++;
      }
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  Future<bool> _createTable(String name, String restaurantId) async {
    try {
      final netWorkMmenu = NetWorkMmenu();
      await netWorkMmenu.dio.post(
        '$baseUrlMmenu/restaurants/$restaurantId/table',
        data: {
          "name": name,
          "position": "khu vuc 1",
        },
      );
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}

final createTableProviders =
    StateNotifierProvider<CreateTableStateProviders, List<CreateTableElement>>(
        (ref) => CreateTableStateProviders());

class CreateTableStateProviders
    extends StateNotifier<List<CreateTableElement>> {
  CreateTableStateProviders()
      : super([
          CreateTableElement(TableElementType.text, text: 'A'),
          CreateTableElement(
            TableElementType.number,
            countNumberMethod: CountNumberMethod.begin0AndCount1,
            countNumberType: CountNumberType.startingFromZero,
          ),
        ]);
  List<CreateTableElement> get data => state;

  List<String> generate(int numbers) {
    try {
      final List<String> result = [];
      for (int i = 0; i < numbers; i++) {
        result.add(data.map((e) => e.calcValue).join());
      }
      data.refresh();
      return result;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}

enum CountNumberMethod {
  begin0AndCount1,
  begin1AndCount1,
  begin0AndCount2,
  begin1AndCount2,
}

enum CountNumberType {
  startingFromZero,
  notStartingFromZero,
}

extension on List<CreateTableElement> {
  void refresh() {
    for (var element in this) {
      element._refreshCountNumber();
    }
  }
}

extension on CountNumberMethod {
  int get startNumber {
    switch (this) {
      case CountNumberMethod.begin0AndCount1:
      case CountNumberMethod.begin0AndCount2:
        return 0;
      case CountNumberMethod.begin1AndCount1:
      case CountNumberMethod.begin1AndCount2:
        return 1;
    }
  }
}

enum TableElementType {
  number,
  text,
}

class CreateTableElement {
  final CountNumberType? countNumberType;
  final CountNumberMethod? countNumberMethod;
  final String? text;
  final TableElementType type;

  int _countNumber;

  String get calcValue {
    switch (type) {
      case TableElementType.number:
        String temp = '';
        switch (countNumberMethod) {
          case CountNumberMethod.begin0AndCount1:
          case CountNumberMethod.begin1AndCount1:
            temp = (_countNumber++).toString();
            break;
          case CountNumberMethod.begin0AndCount2:
          case CountNumberMethod.begin1AndCount2:
            temp = _countNumber.toString();
            _countNumber += 2;
            break;
          default:
            break;
        }

        switch (countNumberType) {
          case CountNumberType.startingFromZero:
            return '0$temp';
          case CountNumberType.notStartingFromZero:
            return temp;
          default:
            return temp;
        }

      case TableElementType.text:
        return text!;
      default:
        return '';
    }
  }

  CreateTableElement(
    this.type, {
    this.countNumberType,
    this.countNumberMethod,
    this.text,
  }) : _countNumber = countNumberMethod?.startNumber ?? -1;

  _refreshCountNumber() {
    _countNumber = countNumberMethod?.startNumber ?? -1;
  }

  CreateTableElement copyWith({
    CountNumberType? countNumberStyle,
    CountNumberMethod? countNumberType,
    String? text,
  }) {
    return CreateTableElement(
      type,
      countNumberType: countNumberStyle,
      countNumberMethod: countNumberType,
      text: text,
    );
  }
}
