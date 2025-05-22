// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:s_c/features/splash/domain/repositories/splash_repository.dart';
import 'package:s_c/features/splash/domain/usecases/check_remembered_login.dart';

import 'check_remembered_login_test.mocks.dart';

@GenerateMocks([SplashRepository])
void main() {
  late MockSplashRepository mockSplashRepository;
  late CheckRememberedLogin usecase;
  const SCUser admin = SCUser(username: "admin", password: "admin");

  setUp(() {
    mockSplashRepository = MockSplashRepository();
    usecase = CheckRememberedLogin(repository: mockSplashRepository);
  });

  test(
    'should get admin from the repository',
    () async {
      //arange

      when(mockSplashRepository.checkRememberedLogin())
          .thenAnswer((_) async => const Right(admin));
      //act
      final result = await usecase(NoParams());
      //assert
      expect(result, equals(const Right(admin)));
      verify(mockSplashRepository.checkRememberedLogin());
      verifyNoMoreInteractions(mockSplashRepository);
    },
  );
}
