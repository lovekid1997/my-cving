import 'package:equatable/equatable.dart';

class NumberE extends Equatable {
  final num number;

  const NumberE(this.number);

  @override
  List<Object?> get props => [number];
}
