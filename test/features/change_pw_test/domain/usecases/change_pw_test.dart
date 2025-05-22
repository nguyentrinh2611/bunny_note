// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/features/change_pw/domain/repositories/change_pw_repository.dart';
import 'package:s_c/features/change_pw/domain/usecases/change_pw.dart';

import 'change_pw_test.mocks.dart';

@GenerateMocks([ChangePwRepository])
main() {
  late MockChangePwRepository mockChangePwRepository;
  late ChangePw usecase;

  setUp(() {
    mockChangePwRepository = MockChangePwRepository();
    usecase = ChangePw(repository: mockChangePwRepository);
  });

  test(
    'should connect usecase to repository',
    () async {
      const user = SCUser(username: "a", password: "123456", uid: "uid");
      //arange

      when(mockChangePwRepository.changPw(newUser: user)).thenAnswer(
        (_) async => const Right(user),
      );
      //act
      final result = await usecase(const ChangePwParams(user: user));
      //assert
      expect(result, equals(const Right(user)));
      verify(mockChangePwRepository.changPw(newUser: user));
      verifyNoMoreInteractions(mockChangePwRepository);
    },
  );
}
