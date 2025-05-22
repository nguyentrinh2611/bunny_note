import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/failures.dart';

abstract class RegisterRepository {
  Future<Either<Failure, SCUser>> createUserWithEmailAndPassword(
      {required String username, required String password});

  Future<Either<Failure, String>> createUserTasksCategory({
    required String uid,
  });
}
