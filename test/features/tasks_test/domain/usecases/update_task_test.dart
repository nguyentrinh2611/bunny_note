// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/features/register/data/models/task_model.dart';

import 'package:s_c/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:s_c/features/tasks/domain/usecases/update_task.dart';
import 'package:uuid/uuid.dart';

import 'update_task_test.mocks.dart';

@GenerateMocks([TasksRepository])
main() {
  late UpdateTask usecase;
  late MockTasksRepository mockTasksRepository;

  setUp(() {
    mockTasksRepository = MockTasksRepository();
    usecase = UpdateTask(repository: mockTasksRepository);
  });
  test("Should connect usecase to repository", () async {
    final String taskUid = const Uuid().v4();
    final TaskModel defaultTask = TaskModel(
      uid: taskUid,
      userId: "uid",
      title: 'Chào mừng đến với Self-Control',
      description: 'Chào mừng đến với Self-Control',
      starttime: DateTime.now(),
      duetime: DateTime.now(),
    );
    // arrange
    when(mockTasksRepository.updateTask(
            parram: UpdateTaskParram(tasks: [defaultTask])))
        .thenAnswer((realInvocation) async => const Right("true"));

    //act
    final result = await usecase.call(UpdateTaskParram(tasks: [defaultTask]));

    //expect
    expect(result, const Right("true"));
    verify(mockTasksRepository.updateTask(
        parram: UpdateTaskParram(tasks: [defaultTask])));
  });
}
