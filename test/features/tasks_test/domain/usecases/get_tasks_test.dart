// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/features/register/domain/entities/task.dart';

import 'package:s_c/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:s_c/features/tasks/domain/usecases/get_tasks.dart';

import 'get_tasks_test.mocks.dart';

@GenerateMocks([TasksRepository])
void main() {
  late MockTasksRepository mockTasksRepository;
  late GetTasks usecase;

  setUp(() {
    mockTasksRepository = MockTasksRepository();
    usecase = GetTasks(repository: mockTasksRepository);
  });

  test("Should connect usecase to repository", () async {
    // arrange
    when(mockTasksRepository.getTasks(userUid: "uid"))
        .thenAnswer((realInvocation) async => const Right(<SCTask>[]));

    //act
    final result = await usecase.call(const GetTasksParram(userUid: "uid"));

    //expect
    expect(result, const Right(<SCTask>[]));
    verify(mockTasksRepository.getTasks(userUid: "uid"));
  });
}
