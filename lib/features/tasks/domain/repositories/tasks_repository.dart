import 'package:dartz/dartz.dart' hide Task;

import '../../../../core/error/failures.dart';
import '../../../register/domain/entities/task.dart';
import '../usecases/delete_task.dart';
import '../usecases/update_task.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<SCTask>>> getTasks({
    required String userUid,
  });
  Future<Either<Failure, String>> addNewTask({
    required SCTask newTask,
  });
  Future<Either<Failure, String>> updateTask({
    required UpdateTaskParram parram,
  });
  Future<Either<Failure, String>> deletetask({
    required DeleteTaskParams parram,
  });
}
