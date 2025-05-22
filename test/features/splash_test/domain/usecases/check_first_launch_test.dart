// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:s_c/features/splash/domain/repositories/splash_repository.dart';
import 'package:s_c/features/splash/domain/usecases/check_first_launch.dart';

import 'check_remembered_login_test.mocks.dart';

@GenerateMocks([SplashRepository])
main() {
  late MockSplashRepository mockSplashRepository;
  late CheckFirstLaunch usecase;
  setUp(() {
    mockSplashRepository = MockSplashRepository();
    usecase = CheckFirstLaunch(repository: mockSplashRepository);
  });

  test(
    'should return is First launch from the repository',
    () async {
      //arange

      when(mockSplashRepository.checkFirstLaunch())
          .thenAnswer((_) async => const Right(true));
      //act
      final result = await usecase(NoParams());
      //assert
      expect(result, equals(const Right(true)));
      verify(mockSplashRepository.checkFirstLaunch());
      verifyNoMoreInteractions(mockSplashRepository);
    },
  );
}
