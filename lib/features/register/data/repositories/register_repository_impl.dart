import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_datasource.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  RegisterRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, SCUser>> createUserWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final SCUser result =
            await remoteDataSource.createUserWithEmailAndPassword(
                username: username, password: password);
        return Right(result);
      } on AuthException catch (e) {
        return Left(ServerFailure(errorCode: e.errorCode));
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> createUserTasksCategory({
    required String uid,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final String result =
            await remoteDataSource.createUserTasksCategory(uid: uid);
        return Right(result);
      } on AuthException catch (e) {
        return Left(ServerFailure(errorCode: e.errorCode));
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(ServerFailure());
    }
  }
}
