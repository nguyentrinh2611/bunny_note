import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/data/datasources/app_local_data_source.dart';
import 'package:s_c/app/data/repositories/app_repository_impl.dart';
import 'package:s_c/core/error/exceptions.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/usecases/usecase.dart';

import 'app_repository_test.mocks.dart';

@GenerateMocks([
  AppLocalDataSource,
])
void main() {
  late AppRepositoryImpl repository;
  late MockAppLocalDataSource localDataSource;
  const String username = "admin@self-control.com";
  const String password = "123456";
  const String uid = "uid";

  setUp(() {
    localDataSource = MockAppLocalDataSource();
    repository = AppRepositoryImpl(localDataSource: localDataSource);
  });

  group("cached user", () {
    test(
        'should cache the data locally when login and enable remember account is successful',
        () async {
      //arrange
      when(localDataSource.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      )).thenAnswer((_) async => true);
      //act
      final result = await repository.rememberAccount(
        username: username,
        password: password,
        uid: uid,
      );
      expect(result, const Right(true));
      //assert
      verify(localDataSource.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      ));
    });

    test(
        'should cache the data locally when login and enable remember account is failure',
        () async {
      //arrange
      when(localDataSource.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      )).thenAnswer((_) async => false);
      //act
      final result = await repository.rememberAccount(
        username: username,
        password: password,
        uid: uid,
      );
      expect(result, const Right(false));
      //assert
      verify(localDataSource.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      ));
    });

    test(
        'should cache the data locally when login and enable remember account is failure by exception',
        () async {
      //arrange
      when(localDataSource.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      )).thenThrow(CacheException());
      //act
      final result = await repository.rememberAccount(
        username: username,
        password: password,
        uid: uid,
      );
      expect(result, Left(CacheFailure()));
      //assert
      verify(localDataSource.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      ));
    });
  });

  group("clear cached user", () {
    test(
        'should remove cache the data locally when login and enable remember account is successful',
        () async {
      //arrange
      when(localDataSource.clearCachedAccount(noParams: NoParams()))
          .thenAnswer((_) async => true);
      //act
      final result = await repository.clearRememberedAccount(NoParams());
      expect(result, const Right(true));
      //assert
      verify(localDataSource.clearCachedAccount(noParams: NoParams()));
    });

    test('should remember account failed', () async {
      //arrange
      when(localDataSource.clearCachedAccount(noParams: NoParams()))
          .thenAnswer((_) async => false);
      //act
      final result = await repository.clearRememberedAccount(NoParams());
      expect(result, const Right(false));
      //assert
      verify(localDataSource.clearCachedAccount(noParams: NoParams()));
    });

    test('should remember account failed by exception', () async {
      //arrange
      when(localDataSource.clearCachedAccount(noParams: NoParams()))
          .thenThrow(CacheException());
      //act
      final result = await repository.clearRememberedAccount(NoParams());
      expect(result, Left(CacheFailure()));
      //assert
      verify(localDataSource.clearCachedAccount(noParams: NoParams()));
    });
  });
}
