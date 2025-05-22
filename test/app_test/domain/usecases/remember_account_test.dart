import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/app/domain/repositories/app_repository.dart';
import 'package:s_c/app/domain/usecases/remember_account.dart';

import 'remember_account_test.mocks.dart';

@GenerateMocks([AppRepository])
void main() {
  late MockAppRepository mockAppRepository;
  late RememberAccount usecase;
  const String username = "admin@self-control.com";
  const String password = "123456";
  const String uid = "uid";
  const SCUser user = SCUser(username: username, password: password, uid: uid);

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = RememberAccount(repository: mockAppRepository);
  });

  test(
    'should return true from repository',
    () async {
      //arange
      when(mockAppRepository.rememberAccount(
              username: username, password: password, uid: uid))
          .thenAnswer((_) async => const Right(true));
      //act
      final result = await usecase(user);
      //assert
      expect(result, equals(const Right(true)));
      verify(mockAppRepository.rememberAccount(
        username: username,
        password: password,
        uid: uid,
      ));
      verifyNoMoreInteractions(mockAppRepository);
    },
  );
}
