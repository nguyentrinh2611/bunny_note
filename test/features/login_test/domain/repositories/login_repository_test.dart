import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/core/error/exceptions.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/network/network_info.dart';
import 'package:s_c/features/login/data/datasources/login_remote_data_source.dart';
import 'package:s_c/features/login/data/repositories/login_repository_impl.dart';
import 'package:s_c/features/splash/data/models/sc_user_model.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([
  LoginRemoteDataSource,
  NetworkInfo
], customMocks: [
  MockSpec<LoginRemoteDataSource>(
      as: #MockNumberTriviaRemoteDataSourceForTest,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late LoginRepositoryImpl repository;
  late MockLoginRemoteDataSource mockRemoteDataSource;

  late MockNetworkInfo mockNetworkInfo;
  const String username = "admin@self-control.com";
  const String password = "123456";

  const SCUser user =
      SCUser(username: username, password: password, uid: "test UID");
  SCUserModel userModel = const SCUserModel(
      password: password, username: username, uid: "test UID");

  setUp(() {
    mockRemoteDataSource = MockLoginRemoteDataSource();

    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("Login with user name and pw", () {
    runTestsOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //arrange
        when(mockRemoteDataSource.loginWithUsernameAndPw(
                username: username, password: password))
            .thenAnswer((_) async => userModel);
        //act
        final result = await repository.loginWithUsernameAndPw(
            username: username, password: password);
        //assert
        verify(mockRemoteDataSource.loginWithUsernameAndPw(
            username: username, password: password));
        expect(result, equals(const Right(user)));
      });
    });
    runTestsOffline(() {
      test('should return ServerFailure when no connecttion', () async {
        //arrange
        when(mockRemoteDataSource.loginWithUsernameAndPw(
                username: username, password: password))
            .thenThrow(AuthException(errorCode: ""));
        //act
        final result = await repository.loginWithUsernameAndPw(
            username: username, password: password);
        //assert
        verify(mockRemoteDataSource.loginWithUsernameAndPw(
            username: username, password: password));
        expect(result, equals(const Left(ServerFailure(errorCode: ""))));
      });
    });
  });
}
