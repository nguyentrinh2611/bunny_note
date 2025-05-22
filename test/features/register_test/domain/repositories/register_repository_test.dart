// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/core/error/exceptions.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/network/network_info.dart';

import 'package:s_c/features/register/data/datasources/register_remote_datasource.dart';
import 'package:s_c/features/register/data/repositories/register_repository_impl.dart';

import 'register_repository_test.mocks.dart';

@GenerateMocks([
  RegisterRemoteDataSource,
  NetworkInfo
], customMocks: [
  MockSpec<RegisterRemoteDataSource>(
      as: #MockRegisterRemoteDataSourceForTest,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late RegisterRepositoryImpl registerRepositoryImpl;
  late RegisterRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const String username = "admin@self-control.com";
  const String password = "123456";
  const SCUser user =
      SCUser(username: username, password: password, uid: "uid Test");

  setUp(() {
    mockRemoteDataSource = MockRegisterRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    registerRepositoryImpl = RegisterRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group("device is offline", () {
    test("should return ServerFailure when device is disconnected", () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer(
        (realInvocation) async => false,
      );
      when(mockRemoteDataSource.createUserWithEmailAndPassword(
              username: username, password: password))
          .thenThrow(ServerException());

      //act
      final result =
          await registerRepositoryImpl.createUserWithEmailAndPassword(
              username: username, password: password);
      final result2 =
          await registerRepositoryImpl.createUserTasksCategory(uid: "uid");

      //assert
      expect(result, const Left(ServerFailure()));
      expect(result2, const Left(ServerFailure()));
      verify(mockNetworkInfo.isConnected);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group("Test register => ", () {
    test("should return a SCUser with uid ", () async {
      when(mockNetworkInfo.isConnected).thenAnswer(
        (realInvocation) async => true,
      );
      when(mockRemoteDataSource.createUserWithEmailAndPassword(
              username: username, password: password))
          .thenAnswer((realInvocation) async => user);
      //act
      final result =
          await registerRepositoryImpl.createUserWithEmailAndPassword(
              username: username, password: password);

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.createUserWithEmailAndPassword(
          username: username, password: password));
      expect(result, const Right(user));
    });
  });

  group("Test CreateUserTasksCategory", () {});
}
