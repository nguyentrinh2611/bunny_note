// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:s_c/features/register/domain/entities/task.dart';
import 'package:s_c/features/tasks/domain/repositories/tasks_repository.dart';

import '../../../../core/error/failures.dart';

class UpdateTaskParram extends DefaultParams {
  final List<SCTask> tasks;
  const UpdateTaskParram({
    required this.tasks,
  });
  @override
  List<Object?> get props => [isShowDefaultLoading, tasks];
}

class UpdateTask implements UseCase<String, UpdateTaskParram> {
  final TasksRepository repository;
  UpdateTask({
    required this.repository,
  });
  @override
  Future<Either<Failure, String>?> call(UpdateTaskParram params) async {
    return await repository.updateTask(parram: params);
  }
}
