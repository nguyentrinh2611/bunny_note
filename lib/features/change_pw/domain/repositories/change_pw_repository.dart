import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

import '../../../../app/domain/entities/sc_user.dart';

abstract class ChangePwRepository {
  Future<Either<Failure, SCUser>> changPw({required SCUser newUser});
}
