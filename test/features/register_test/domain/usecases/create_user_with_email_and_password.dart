import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/features/register/domain/repositories/register_repository.dart';
import 'package:s_c/features/register/domain/usecases/create_user_with_email_and_password.dart';

import 'create_user_with_email_and_password.mocks.dart';

@GenerateMocks([RegisterRepository])
main() {
  late MockRegisterRepository mockRegisterRepository;
  late CreateUserWithEmailAndPassword usecase;

  const String username = "admin@self-control.com";
  const String password = "123456";
  const SCUser user =
      SCUser(username: username, password: password, uid: "uid Test");

  setUp(() {
    mockRegisterRepository = MockRegisterRepository();
    usecase = CreateUserWithEmailAndPassword(
      repository: mockRegisterRepository,
    );
  });

  test("should answer data from repository", () async {
    //arrange
    when(mockRegisterRepository.createUserWithEmailAndPassword(
            username: username, password: password))
        .thenAnswer((_) async => const Right(user));

    //act
    final result = await usecase
        .call(const SCUser(username: username, password: password));
    //assert
    expect(result, const Right(user));
    verify(mockRegisterRepository.createUserWithEmailAndPassword(
        username: username, password: password));
  });
}
