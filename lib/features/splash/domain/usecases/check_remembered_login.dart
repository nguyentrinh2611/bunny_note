// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/splash_repository.dart';

class CheckRememberedLogin extends UseCase<SCUser, NoParams> {
  final SplashRepository repository;
  CheckRememberedLogin({
    required this.repository,
  });

  @override
  Future<Either<Failure, SCUser>?> call(NoParams params) async {
    return await repository.checkRememberedLogin();
  }
}
