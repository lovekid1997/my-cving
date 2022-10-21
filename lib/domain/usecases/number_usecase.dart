import 'package:dartz/dartz.dart';
import 'package:my_cving/core/failures.dart';
import 'package:my_cving/domain/entities/number.dart';
import 'package:my_cving/domain/repositories/number_repository.dart';

class NumberUsecase {
  final NumberRepository numberRepository;

  NumberUsecase(this.numberRepository);

  Future<Either<Failures, NumberE>> getNumber() async {
    return await numberRepository.getNumber();
  }
}
