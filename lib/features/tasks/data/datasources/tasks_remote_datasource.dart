import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/enum/app_constants.dart';
import '../../../register/domain/entities/task.dart';

abstract class TasksRemoteDataSource {
  Future<List<SCTask>> getTasks({required String userUid});

  Future<String> addNewTask({required SCTask newTask});

  Future<String> updateTask({required List<SCTask> task});

  Future<String> deleteTask({required List<SCTask> task});
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final Dio dio;
  final FirebaseApp? firebaseApp;

  TasksRemoteDataSourceImpl({
    required this.dio,
    this.firebaseApp,
  });
  @override
  Future<List<SCTask>> getTasks({required String userUid}) async {
    try {
      final String dbUrl = firebaseApp?.options.databaseURL ?? "";

      final Response response =
          await dio.get("$dbUrl/$TASKS_CATEGORY/$userUid.json");

      final List<SCTask> tasks = [];

      for (var element in response.data) {
        final SCTask task = SCTask.fromMap(element);

        tasks.add(task);
      }

      return tasks;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String> addNewTask({required SCTask newTask}) async {
    try {
      final String dbUrl = firebaseApp?.options.databaseURL ?? "";
      final List<SCTask> list = await getTasks(userUid: newTask.userId ?? "");
      final List<Map<String, dynamic>> data = [];
      for (var element in list) {
        data.add(element.toMap());
      }
      data.add(newTask.toMap());

      final patchRes = await dio.patch("$dbUrl/$TASKS_CATEGORY.json", data: {
        newTask.userId: data,
      });
      return patchRes.statusCode.toString();
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<String> updateTask({required List<SCTask> task}) async {
    final String userId = task.first.userId ?? "";
    final String dbUrl = firebaseApp?.options.databaseURL ?? "";
    final List<Map<String, dynamic>> data = [];
    for (var element in task) {
      data.add(element.toMap());
    }

    final patchRes = await dio.patch("$dbUrl/$TASKS_CATEGORY.json", data: {
      userId: data,
    });
    return patchRes.statusCode.toString();
  }

  @override
  Future<String> deleteTask({required List<SCTask> task}) async {
    final String userId = task.first.userId ?? "";
    final String dbUrl = firebaseApp?.options.databaseURL ?? "";
    final List<Map<String, dynamic>> data = [];
    for (var element in task) {
      data.add(element.toMap());
    }

    final patchRes = await dio.patch("$dbUrl/$TASKS_CATEGORY.json", data: {
      userId: data,
    });
    return patchRes.statusCode.toString();
  }
}
