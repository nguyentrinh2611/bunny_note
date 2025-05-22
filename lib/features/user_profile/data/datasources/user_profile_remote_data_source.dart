// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:s_c/core/error/exceptions.dart';

import 'package:s_c/features/user_profile/data/models/user_profile_model.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfileModel> getUserProfile({
    required String userId,
  });

  Future<UserProfileModel> setUserProfile({
    required String userId,
    required UserProfileModel userProfile,
  });
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final Dio dio;
  final FirebaseApp? firebaseApp;
  UserProfileRemoteDataSourceImpl({
    required this.dio,
    this.firebaseApp,
  });
  @override
  Future<UserProfileModel> getUserProfile({required String userId}) async {
    try {
      final String dbUrl = firebaseApp?.options.databaseURL ?? "";
      final result = await dio.get("$dbUrl/users/$userId.json");

      final obj = UserProfileModel.fromMap(result.data);

      return obj;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserProfileModel> setUserProfile({
    required String userId,
    required UserProfileModel userProfile,
  }) async {
    try {
      final String dbUrl = firebaseApp?.options.databaseURL ?? "";
      await dio.patch("$dbUrl/users/$userId.json", data: userProfile.toMap());

      return userProfile;
    } catch (e) {
      throw ServerException();
    }
  }
}
