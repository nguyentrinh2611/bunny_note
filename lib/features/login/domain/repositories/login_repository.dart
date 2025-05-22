import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, SCUser>> loginWithUsernameAndPw({
    required String username,
    required String password,
  });
}
