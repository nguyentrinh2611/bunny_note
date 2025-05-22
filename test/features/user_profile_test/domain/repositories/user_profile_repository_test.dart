// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/core/error/exceptions.dart';

import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/network/network_info.dart';
import 'package:s_c/features/user_profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:s_c/features/user_profile/data/models/user_profile_model.dart';
import 'package:s_c/features/user_profile/data/repositories/user_profile_repository_impl.dart';
import 'package:s_c/features/user_profile/domain/usecases/get_user_profile.dart';
import 'package:s_c/features/user_profile/domain/usecases/set_user_profile.dart';

import 'user_profile_repository_test.mocks.dart';

@GenerateMocks([
  UserProfileRemoteDataSource,
  NetworkInfo
], customMocks: [
  MockSpec<UserProfileRemoteDataSource>(
      as: #UserProfileRemoteDataSourceForTest,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late MockUserProfileRemoteDataSource remoteDataSourceImpl;
  late MockNetworkInfo mockNetworkInfo;
  late UserProfileRepositoryImpl repositoryImpl;
  setUp(() {
    remoteDataSourceImpl = MockUserProfileRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = UserProfileRepositoryImpl(
        remoteDataSource: remoteDataSourceImpl, networkInfo: mockNetworkInfo);
  });

  const res = UserProfileModel(
      name: "name",
      address: "address",
      phone: "phone",
      gender: "gender",
      avatarUrl: "avatarUrl");

  test("> Device is Offline", () async {
    when(mockNetworkInfo.isConnected)
        .thenAnswer((realInvocation) async => false);

    final result = await repositoryImpl.getUserProfile(
        params: const GetUserProfileParams(userId: "userId"));
    expect(result, const Left(NetworkFailure()));
    verifyNoMoreInteractions(remoteDataSourceImpl);
  });

  group(">Device is online", () {
    test("User profile doesn't existed", () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(remoteDataSourceImpl.getUserProfile(userId: "userId"))
          .thenThrow(ServerException(errorCode: "unknow"));

      final result = await repositoryImpl.getUserProfile(
          params: const GetUserProfileParams(userId: "userId"));
      expect(result, const Left(ServerFailure(errorCode: "unknow")));
    });
    test("User profile existed", () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(remoteDataSourceImpl.getUserProfile(userId: "userId"))
          .thenAnswer((realInvocation) async => Future.value(res));
      final result = await repositoryImpl.getUserProfile(
          params: const GetUserProfileParams(userId: "userId"));
      expect(result, const Right(res));
    });

    test("> Update User profile Success", () async {
      when(mockNetworkInfo.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(remoteDataSourceImpl.setUserProfile(
              userId: "userId", userProfile: res))
          .thenAnswer((realInvocation) async => Future.value(res));
      final result = await repositoryImpl.setUserProfile(
        params: const SetUserProfileParams(userId: "userId", userProfile: res),
      );
      expect(result, const Right(res));
    });
  });
}
