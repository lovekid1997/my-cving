import 'package:dartz/dartz.dart';
import 'package:my_cving/domain/entities/number.dart';
import '../../core/failures.dart';

abstract class NumberRepository {
  Future<Either<Failures, NumberE>> getNumber();
}
