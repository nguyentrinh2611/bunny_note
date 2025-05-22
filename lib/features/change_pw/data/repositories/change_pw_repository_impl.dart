// ignore_for_file: unused_local_variable

import 'package:dartz/dartz.dart';
import 'package:s_c/features/change_pw/domain/repositories/change_pw_repository.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/logger.dart';
import '../datasources/change_pw_local_data_source.dart';
import '../datasources/change_pw_remote_data_source.dart';

class ChangePwRepositoryImpl implements ChangePwRepository {
  final ChangePwLocalDataSource localDataSource;
  final ChangePwRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  ChangePwRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, SCUser>> changPw({required SCUser newUser}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.changePw(newPassword: newUser.password);
        try {
          final cachedResult =
              await localDataSource.saveChangedPw(user: newUser);
          return Right(newUser);
        } catch (cachedExeoption) {
          AppLogger.instance.e(cachedExeoption);
          return Left(CacheFailure());
        }
      } on ServerException catch (e) {
        AppLogger.instance.e(e);
        return Left(ServerFailure(errorCode: e.errorCode ?? ""));
      } catch (er) {
        AppLogger.instance.e(er);
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
