import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

abstract class AppRepository {
  Future<Either<Failure, bool>> rememberAccount({
    required String username,
    required String password,
    required String uid,
  });

  Future<Either<Failure, bool>> clearRememberedAccount(NoParams noParams);
}
