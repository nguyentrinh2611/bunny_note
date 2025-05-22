// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_data_source.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource localDataSource;
  SplashRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, bool>>? checkFirstLaunch() async {
    final bool result =
        await localDataSource.getCachedFirstLaunchFlag() == true;
    return Right(result);
  }

  @override
  Future<Either<Failure, SCUser>>? checkRememberedLogin() async {
    try {
      final SCUser? user = await localDataSource.getRememberedAccount();
      return Right(user!);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
