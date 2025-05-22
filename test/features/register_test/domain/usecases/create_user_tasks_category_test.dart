// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:s_c/features/register/domain/repositories/register_repository.dart';
import 'package:s_c/features/register/domain/usecases/create_user_tasks_category.dart';

import 'create_user_tasks_category_test.mocks.dart';

@GenerateMocks([RegisterRepository])
void main() {
  late MockRegisterRepository mockRegisterRepository;

  late CreateUserTasksCategory usecase;
  setUp(() {
    mockRegisterRepository = MockRegisterRepository();

    usecase = CreateUserTasksCategory(
      repository: mockRegisterRepository,
    );
  });
  test(
    'should get trivia for the number from the repository',
    () async {
      //arange
      when(mockRegisterRepository.createUserTasksCategory(uid: "uid"))
          .thenAnswer((_) async => const Right("name"));
      //act
      final result =
          await usecase(const CreateUserTasksCategoryParram(uid: "uid"));
      //assert
      expect(result, equals(const Right("name")));
      verify(mockRegisterRepository.createUserTasksCategory(uid: "uid"));
      verifyNoMoreInteractions(mockRegisterRepository);
    },
  );
}
