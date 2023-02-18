// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TablePosition _$TablePositionFromJson(Map<String, dynamic> json) =>
    TablePosition(
      json['tablePositionName'] as String? ?? '',
    );

Map<String, dynamic> _$TablePositionToJson(TablePosition instance) =>
    <String, dynamic>{
      'tablePositionName': instance.name,
    };

TablePositions _$TablePositionsFromJson(Map<String, dynamic> json) =>
    TablePositions(
      (json['tablePositions'] as List<dynamic>?)
              ?.map((e) => TablePosition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TablePositionsToJson(TablePositions instance) =>
    <String, dynamic>{
      'tablePositions': instance.positions,
    };
