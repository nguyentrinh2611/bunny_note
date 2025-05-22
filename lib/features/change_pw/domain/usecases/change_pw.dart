import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/change_pw_repository.dart';

class ChangePw extends UseCase<SCUser, ChangePwParams> {
  final ChangePwRepository repository;
  ChangePw({
    required this.repository,
  });
  @override
  Future<Either<Failure, SCUser>?> call(ChangePwParams params) async {
    return await repository.changPw(newUser: params.user);
  }
}

class ChangePwParams extends DefaultParams {
  final SCUser user;
  const ChangePwParams({required this.user});
}
