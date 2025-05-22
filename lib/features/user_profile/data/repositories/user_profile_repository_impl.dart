import 'package:dartz/dartz.dart';
import 'package:s_c/features/user_profile/domain/usecases/set_user_profile.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/user_profile_remote_data_source.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../../domain/usecases/get_user_profile.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  UserProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, UserProfile>> getUserProfile({
    required GetUserProfileParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await remoteDataSource.getUserProfile(userId: params.userId);
        return Right(result);
      } on ServerException catch (sve) {
        return Left(ServerFailure(errorCode: sve.errorCode ?? ""));
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfile>> setUserProfile({
    required SetUserProfileParams params,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.setUserProfile(
            userId: params.userId, userProfile: params.userProfile);
        return Right(result);
      } on ServerException catch (sve) {
        return Left(ServerFailure(errorCode: sve.errorCode ?? ""));
      } catch (e) {
        return const Left(ServerFailure());
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
