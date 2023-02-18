import 'package:json_annotation/json_annotation.dart';
part 'table_position.g.dart';

@JsonSerializable()
class TablePosition {
  @JsonKey(
    name: 'tablePositionName',
    defaultValue: '',
  )
  final String name;
  TablePosition(this.name);
  factory TablePosition.fromJson(Map<String, dynamic> json) =>
      _$TablePositionFromJson(json);

  Map<String, dynamic> toJson() => _$TablePositionToJson(this);
}

@JsonSerializable()
class TablePositions {
  @JsonKey(
    name: 'tablePositions',
    defaultValue: [],
  )
  final List<TablePosition> positions;
  TablePositions(this.positions);
  
  factory TablePositions.fromJson(Map<String, dynamic> json) =>
      _$TablePositionsFromJson(json);

  Map<String, dynamic> toJson() => _$TablePositionsToJson(this);
}
