// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';

import 'package:s_c/core/error/exceptions.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/network/network_info.dart';
import 'package:s_c/features/change_pw/data/datasources/change_pw_local_data_source.dart';
import 'package:s_c/features/change_pw/data/datasources/change_pw_remote_data_source.dart';
import 'package:s_c/features/change_pw/data/repositories/change_pw_repository_impl.dart';

import 'change_pw_repository_test.mocks.dart';

@GenerateMocks([
  ChangePwRemoteDataSource,
  ChangePwLocalDataSource,
  NetworkInfo
], customMocks: [
  MockSpec<ChangePwRemoteDataSource>(
    as: #ChangePwRemoteDataSourceForTest,
    onMissingStub: OnMissingStub.returnDefault,
  ),
])
void main() {
  late MockChangePwRemoteDataSource mockChangePwRemoteDataSource;
  late MockChangePwLocalDataSource mockChangePwLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late ChangePwRepositoryImpl repositoryImpl;
  const user = SCUser(username: "a", password: "123456", uid: "uid");

  setUp(() {
    mockChangePwLocalDataSource = MockChangePwLocalDataSource();
    mockChangePwRemoteDataSource = MockChangePwRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = ChangePwRepositoryImpl(
      localDataSource: mockChangePwLocalDataSource,
      remoteDataSource: mockChangePwRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group("Device is offline", () {
    test("Should return network failure when device is offlibe", () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => false);

      //act
      final result = await repositoryImpl.changPw(newUser: user);

      //expect
      expect(result, isA<Left<Failure, SCUser>>());
      verifyNoMoreInteractions(mockChangePwRemoteDataSource);
      verifyNoMoreInteractions(mockChangePwLocalDataSource);
    });
  });

  group("Device is online", () {
    test("connect to network success and change password failure", () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockChangePwRemoteDataSource.changePw(newPassword: "123456"))
          .thenThrow(ServerException());

      //act
      final result = await repositoryImpl.changPw(newUser: user);

      //expect
      expect(result, const Left(ServerFailure()));
      verify(mockChangePwRemoteDataSource.changePw(newPassword: "123456"));
      verifyNoMoreInteractions(mockChangePwLocalDataSource);
    });

    test(
        "connect to network success and change password sucess, then cached newUser to local failure",
        () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockChangePwRemoteDataSource.changePw(newPassword: "123456"))
          .thenAnswer(
        (realInvocation) async => Future.value("123456"),
      );
      when(mockChangePwLocalDataSource.saveChangedPw(user: user))
          .thenThrow(CacheException());

      //act
      final result = await repositoryImpl.changPw(newUser: user);

      //expect
      expect(result, Left(CacheFailure()));
      verify(mockChangePwRemoteDataSource.changePw(newPassword: "123456"));
      verify(mockChangePwLocalDataSource.saveChangedPw(user: user));
    });

    test(
        "connect to network success and change password sucess, then cached newUser to local success",
        () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);

      when(mockChangePwRemoteDataSource.changePw(newPassword: "123456"))
          .thenAnswer(
        (realInvocation) async => Future.value("123456"),
      );
      when(mockChangePwLocalDataSource.saveChangedPw(user: user))
          .thenAnswer((realInvocation) async => user);

      //act
      final result = await repositoryImpl.changPw(newUser: user);

      //expect
      expect(result, const Right(user));
      verify(mockChangePwRemoteDataSource.changePw(newPassword: "123456"));
      verify(mockChangePwLocalDataSource.saveChangedPw(user: user));
    });
  });
}
