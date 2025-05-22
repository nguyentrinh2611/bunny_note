import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/failures.dart';

abstract class SplashRepository {
  Future<Either<Failure, SCUser>>? checkRememberedLogin();
  Future<Either<Failure, bool>>? checkFirstLaunch();
}
