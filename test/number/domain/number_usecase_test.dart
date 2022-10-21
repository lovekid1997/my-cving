import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_cving/domain/entities/number.dart';
import 'package:my_cving/domain/repositories/number_repository.dart';
import 'package:my_cving/domain/usecases/number_usecase.dart';

import 'number_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NumberRepository>()])

void main() {
  late NumberUsecase useCase;
  late MockNumberRepository mockNumberRepository;

  setUp(() {
    mockNumberRepository = MockNumberRepository();
    useCase = NumberUsecase(mockNumberRepository);
  });

  const tNumber = 1;
  const numberE = NumberE(tNumber);

  test('get number from repository', () async {
    when(mockNumberRepository.getNumber())
        .thenAnswer((_) async => const Right(numberE));
    final result = await useCase.getNumber();

    expect(result, const Right(numberE));
    verify(mockNumberRepository.getNumber()).called(1);
    verifyNoMoreInteractions(mockNumberRepository);
  });
}
