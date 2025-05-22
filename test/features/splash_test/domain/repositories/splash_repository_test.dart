// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/core/error/exceptions.dart';
import 'package:s_c/core/error/failures.dart';

import 'package:s_c/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:s_c/features/splash/data/repositories/splash_repository_impl.dart';

import 'splash_repository_test.mocks.dart';

@GenerateMocks([SplashLocalDataSource])
void main() {
  late SplashRepositoryImpl repository;
  late MockSplashLocalDataSource mockSplashLocalDataSource;
  setUp(() {
    mockSplashLocalDataSource = MockSplashLocalDataSource();
    repository =
        SplashRepositoryImpl(localDataSource: mockSplashLocalDataSource);
  });

  group('check First Launch', () {
    test('should return true', () async {
      //arrange
      when(mockSplashLocalDataSource.getCachedFirstLaunchFlag())
          .thenAnswer((_) async => true);
      //act
      final result = await repository.checkFirstLaunch();
      //assert
      verify(mockSplashLocalDataSource.getCachedFirstLaunchFlag());
      expect(result, equals(const Right(true)));
    });

    test('should return false if data is null', () async {
      //arrange
      when(mockSplashLocalDataSource.getCachedFirstLaunchFlag())
          .thenAnswer((_) async => false);
      //act
      final result = await repository.checkFirstLaunch();
      //assert
      verify(mockSplashLocalDataSource.getCachedFirstLaunchFlag());
      expect(result, equals(const Right(false)));
    });
  });

  group('check remmembered account', () {
    const SCUser user = SCUser(username: "admin", password: "admin");
    test('should return SCUser("admin", "admin")', () async {
      //arrange
      when(mockSplashLocalDataSource.getRememberedAccount())
          .thenAnswer((_) async => user);
      //act
      final result = await repository.checkRememberedLogin();
      //assert
      verify(mockSplashLocalDataSource.getRememberedAccount());
      expect(result, equals(const Right(user)));
    });

    test('should return a Cached Failure', () async {
      //arrange
      when(mockSplashLocalDataSource.getRememberedAccount())
          .thenThrow(CacheException());
      //act
      final result = await repository.checkRememberedLogin();
      //assert
      verify(mockSplashLocalDataSource.getRememberedAccount());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
