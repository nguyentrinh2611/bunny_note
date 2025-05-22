// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:s_c/app/data/datasources/app_local_data_source.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource localDataSource;
  AppRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, bool>> rememberAccount({
    required String username,
    required String password,
    required String uid,
  }) async {
    try {
      final result = await localDataSource.cachedAccount(
          username: username, password: password, uid: uid);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> clearRememberedAccount(
      NoParams noParams) async {
    try {
      final result =
          await localDataSource.clearCachedAccount(noParams: noParams);
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
