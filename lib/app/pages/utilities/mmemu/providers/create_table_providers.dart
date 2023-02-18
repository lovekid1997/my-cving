import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_cving/app/config/constant.dart';
import 'package:my_cving/app/pages/utilities/mmemu/elements/table_position.dart';
import 'package:my_cving/app/pages/utilities/mmemu/net_work/net_work.dart';
import 'package:my_cving/app/pages/utilities/mmemu/providers/restaurant_providers.dart';
import 'package:my_cving/app/services/logger.dart';
import 'package:provider/provider.dart';

class TableProviders extends BaseChangeNotifier {
  static TableProviders of(BuildContext context) =>
      context.read<TableProviders>();
  final NetWorkMmenu netWorkMmenu = NetWorkMmenu();
  double progress = 0;
  double _count = 1;
  TablePositions positions = TablePositions([]);
  TablePosition? selectedPosition;

  List<CreateTableElement> createTableElements = [];
  List<String> generated = [];

  addCreateTableElement(CreateTableElement e) {
    createTableElements.add(e);
    notifyListeners();
  }

  void generate(int numbers) {
    try {
      final List<String> result = [];
      for (int i = 0; i < numbers; i++) {
        result.add(createTableElements.map((e) => e.calcValue).join());
      }
      createTableElements.refresh();
      generated
        ..clear()
        ..addAll(result);
      notifyListeners();
    } catch (e) {
      logger.e(e);
    }
  }

  Future createTable({
    required List<String> generated,
    required String positionName,
    required String restaurantId,
  }) async {
    for (var name in generated) {
      final result = await _createTable(
        name: name,
        positionName: positionName,
        restaurantId: restaurantId,
      );
      if (result) {
        progress = _count * 100 / generated.length;
        _count++;
      }
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  Future<bool> _createTable({
    required String name,
    required String positionName,
    required String restaurantId,
  }) async {
    try {
      await netWorkMmenu.dio.post(
        '$baseUrlMmenu/restaurants/$restaurantId/table',
        data: {
          "name": name,
          "position": positionName,
        },
      );
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  Future fetchTablePosition(String restaurantId) async {
    // restaurants/{restaurantId}/table-position
    // get
    try {
      final results = await netWorkMmenu.dio.get(
        '/restaurants/$restaurantId/table-position',
      );
      positions = TablePositions.fromJson(results.data);
      selectedPosition = positions.positions.firstOrNull;
      notifyListeners();
    } on DioError catch (e) {
      logger.e(e);
      addErrorMessage(e);
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
