import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../register/domain/entities/task.dart';
import '../repositories/tasks_repository.dart';

class GetTasks extends UseCase<List<SCTask>, GetTasksParram> {
  final TasksRepository repository;
  GetTasks({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<SCTask>>?> call(GetTasksParram params) async {
    return repository.getTasks(userUid: params.userUid);
  }
}

class GetTasksParram extends DefaultParams {
  final String userUid;
  const GetTasksParram({
    required this.userUid,
  });
}
