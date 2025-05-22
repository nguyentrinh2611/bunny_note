// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../splash/data/models/sc_user_model.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;
  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SCUser>> loginWithUsernameAndPw({
    required String username,
    required String password,
  }) async {
    try {
      final SCUserModel result = await remoteDataSource.loginWithUsernameAndPw(
          username: username, password: password);
      return Right(SCUser(
        username: result.username,
        password: result.password,
        uid: result.uid ?? "",
      ));
    } on AuthException catch (e) {
      return Left(ServerFailure(errorCode: e.errorCode));
    } catch (error) {
      return const Left(ServerFailure());
    }
  }
}
