// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:s_c/features/tasks/domain/repositories/tasks_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../register/domain/entities/task.dart';

class DeleteTaskParams extends DefaultParams {
  final List<SCTask> tasks;
  const DeleteTaskParams({
    required this.tasks,
  });
}

class DeleteTask extends UseCase<String, DeleteTaskParams> {
  final TasksRepository repository;
  DeleteTask({
    required this.repository,
  });
  @override
  Future<Either<Failure, String>?> call(DeleteTaskParams params) async {
    return await repository.deletetask(parram: params);
  }
}
