import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/register_repository.dart';

class CreateUserTasksCategoryParram extends DefaultParams {
  final String uid;

  const CreateUserTasksCategoryParram({
    required this.uid,
  });
}

class CreateUserTasksCategory
    implements UseCase<String, CreateUserTasksCategoryParram> {
  final RegisterRepository repository;
  CreateUserTasksCategory({
    required this.repository,
  });
  @override
  Future<Either<Failure, String>?> call(
      CreateUserTasksCategoryParram params) async {
    return await repository.createUserTasksCategory(uid: params.uid);
  }
}
