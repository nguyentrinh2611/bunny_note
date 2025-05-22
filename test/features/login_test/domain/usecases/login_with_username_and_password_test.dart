// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/features/login/domain/repositories/login_repository.dart';

import 'package:s_c/features/login/domain/usecases/login_with_username_and_pw.dart';

import 'login_with_username_and_password_test.mocks.dart';

@GenerateMocks([LoginRepository])
main() {
  late MockLoginRepository mockLoginRepository;
  late LoginWithUsernameAndPw usecase;
  const String username = "admin@self-control.com";
  const String password = "123456";
  const SCUser user = SCUser(username: username, password: password);

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = LoginWithUsernameAndPw(repository: mockLoginRepository);
  });

  test(
    'should return admin user from repository',
    () async {
      //arange
      when(mockLoginRepository.loginWithUsernameAndPw(
              username: username, password: password))
          .thenAnswer((_) async => const Right(user));
      //act
      final result =
          await usecase(const SCUser(username: username, password: password));
      //assert
      expect(result, equals(const Right(user)));
      verify(mockLoginRepository.loginWithUsernameAndPw(
          username: username, password: password));
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );
}
