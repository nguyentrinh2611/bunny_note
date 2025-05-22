// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart' hide Task;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/network/network_info.dart';
import 'package:s_c/features/register/data/models/task_model.dart';
import 'package:s_c/features/register/domain/entities/task.dart';
import 'package:s_c/features/tasks/data/datasources/tasks_remote_datasource.dart';
import 'package:s_c/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:s_c/features/tasks/domain/usecases/delete_task.dart';
import 'package:s_c/features/tasks/domain/usecases/update_task.dart';
import 'package:uuid/uuid.dart';

import 'tasks_repository_test.mocks.dart';

@GenerateMocks([
  TasksRemoteDataSource,
  NetworkInfo
], customMocks: [
  MockSpec<TasksRemoteDataSource>(
      as: #TasksRemoteDataSourceForTest,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late MockTasksRemoteDataSource mockTasksRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late TasksRepositoryImpl repository;
  setUp(() {
    mockTasksRemoteDataSource = MockTasksRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TasksRepositoryImpl(
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockTasksRemoteDataSource);
  });

  group(">> Device is offline", () {
    test("> Get tasks list", () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(false));

      final result = await repository.getTasks(userUid: "userUid");

      expect(result, equals(const Left(NetworkFailure())));
      verify(repository.getTasks(userUid: "userUid"));
      verifyNoMoreInteractions(mockTasksRemoteDataSource);
    });

    test("> Add new Task", () async {
      final String taskUid = const Uuid().v4();
      final TaskModel defaultTask = TaskModel(
        uid: taskUid,
        userId: "uid",
        title: 'Chào mừng đến với Self-Control',
        description: 'Chào mừng đến với Self-Control',
        starttime: DateTime.now(),
        duetime: DateTime.now(),
      );
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(false));

      final result = await repository.addNewTask(
        newTask: defaultTask,
      );

      expect(result, equals(const Left(NetworkFailure())));
      verify(repository
        ..addNewTask(
          newTask: defaultTask,
        ));
      verifyNoMoreInteractions(mockTasksRemoteDataSource);
    });

    test("> UpdateTask", () async {
      final String taskUid = const Uuid().v4();
      final TaskModel defaultTask = TaskModel(
        uid: taskUid,
        userId: "uid",
        title: 'Chào mừng đến với Self-Control',
        description: 'Chào mừng đến với Self-Control',
        starttime: DateTime.now(),
        duetime: DateTime.now(),
      );
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(false));

      final result = await repository.updateTask(
          parram: UpdateTaskParram(tasks: [defaultTask]));

      expect(result, equals(const Left(NetworkFailure())));
      verify(repository.updateTask(
          parram: UpdateTaskParram(tasks: [defaultTask])));
      verifyNoMoreInteractions(mockTasksRemoteDataSource);
    });

    test("> Delete Task", () async {
      final String taskUid = const Uuid().v4();
      final TaskModel defaultTask = TaskModel(
        uid: taskUid,
        userId: "uid",
        title: 'Chào mừng đến với Self-Control',
        description: 'Chào mừng đến với Self-Control',
        starttime: DateTime.now(),
        duetime: DateTime.now(),
      );
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(false));

      final result = await repository.deletetask(
          parram: DeleteTaskParams(tasks: [defaultTask]));

      expect(result, equals(const Left(NetworkFailure())));
      verify(repository.deletetask(
          parram: DeleteTaskParams(tasks: [defaultTask])));
      verifyNoMoreInteractions(mockTasksRemoteDataSource);
    });
  });

  group(">> Device is online", () {
    List<SCTask> data = <SCTask>[];
    String data2 = "data";
    test("> Get tasks list", () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(true));
      when(mockTasksRemoteDataSource.getTasks(userUid: "userUid"))
          .thenAnswer((realInvocation) async => data);

      final result = await repository.getTasks(userUid: "userUid");

      expect(result, equals(Right(data)));
      verify(mockTasksRemoteDataSource.getTasks(userUid: "userUid"));
    });
    test("> Add new task", () async {
      final String taskUid = const Uuid().v4();
      final TaskModel defaultTask = TaskModel(
        uid: taskUid,
        userId: "uid",
        title: 'Chào mừng đến với Self-Control',
        description: 'Chào mừng đến với Self-Control',
        starttime: DateTime.now(),
        duetime: DateTime.now(),
      );
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(true));
      when(mockTasksRemoteDataSource.addNewTask(newTask: defaultTask))
          .thenAnswer((realInvocation) async => data2);

      final result = await repository.addNewTask(newTask: defaultTask);

      expect(result, equals(Right(data2)));
      verify(mockTasksRemoteDataSource.addNewTask(newTask: defaultTask));
    });

    test("> Update task", () async {
      final String taskUid = const Uuid().v4();
      final TaskModel defaultTask = TaskModel(
        uid: taskUid,
        userId: "uid",
        title: 'Chào mừng đến với Self-Control',
        description: 'Chào mừng đến với Self-Control',
        starttime: DateTime.now(),
        duetime: DateTime.now(),
      );
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(true));
      when(mockTasksRemoteDataSource.updateTask(task: [defaultTask]))
          .thenAnswer((realInvocation) async => data2);

      final result = await repository.updateTask(
          parram: UpdateTaskParram(tasks: [defaultTask]));

      expect(result, equals(Right(data2)));
      verify(mockTasksRemoteDataSource.updateTask(task: [defaultTask]));
    });

    test("> Delete task", () async {
      final String taskUid = const Uuid().v4();
      final TaskModel defaultTask = TaskModel(
        uid: taskUid,
        userId: "uid",
        title: 'Chào mừng đến với Self-Control',
        description: 'Chào mừng đến với Self-Control',
        starttime: DateTime.now(),
        duetime: DateTime.now(),
      );
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => Future.value(true));
      when(mockTasksRemoteDataSource.deleteTask(task: [defaultTask]))
          .thenAnswer((realInvocation) async => data2);

      final result = await repository.deletetask(
          parram: DeleteTaskParams(tasks: [defaultTask]));

      expect(result, equals(Right(data2)));
      verify(mockTasksRemoteDataSource.deleteTask(task: [defaultTask]));
    });
  });
}
