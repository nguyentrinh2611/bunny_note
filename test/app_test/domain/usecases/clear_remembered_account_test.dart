import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/repositories/app_repository.dart';
import 'package:s_c/app/domain/usecases/clear_remembered_account.dart';
import 'package:s_c/core/usecases/usecase.dart';

import 'remember_account_test.mocks.dart';

@GenerateMocks([AppRepository])
void main() {
  late MockAppRepository mockAppRepository;
  late ClearRememberedAccount usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = ClearRememberedAccount(repository: mockAppRepository);
  });

  test(
    'should return true from repository',
    () async {
      //arange
      when(mockAppRepository.clearRememberedAccount(NoParams()))
          .thenAnswer((_) async => const Right(true));
      //act
      final result = await usecase(NoParams());
      //assert
      expect(result, equals(const Right(true)));
      verify(mockAppRepository.clearRememberedAccount(NoParams()));
      verifyNoMoreInteractions(mockAppRepository);
    },
  );
}
