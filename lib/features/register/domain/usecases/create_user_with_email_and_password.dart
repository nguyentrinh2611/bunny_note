import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/register_repository.dart';

class CreateUserWithEmailAndPassword extends UseCase<SCUser, SCUser> {
  final RegisterRepository repository;
  CreateUserWithEmailAndPassword({
    required this.repository,
  });
  @override
  Future<Either<Failure, SCUser>?> call(SCUser params) {
    return repository.createUserWithEmailAndPassword(
        username: params.username, password: params.password);
  }
}
