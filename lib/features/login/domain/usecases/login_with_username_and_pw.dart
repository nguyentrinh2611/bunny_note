// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:s_c/features/login/domain/repositories/login_repository.dart';

import '../../../../app/domain/entities/sc_user.dart';

class LoginWithUsernameAndPw implements UseCase<SCUser, SCUser> {
  final LoginRepository repository;
  LoginWithUsernameAndPw({
    required this.repository,
  });
  @override
  Future<Either<Failure, SCUser>?> call(SCUser params) async {
    return repository.loginWithUsernameAndPw(
        username: params.username, password: params.password);
  }
}
