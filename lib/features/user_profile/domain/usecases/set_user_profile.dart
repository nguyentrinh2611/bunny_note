// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:s_c/features/user_profile/data/models/user_profile_model.dart';
import 'package:s_c/features/user_profile/domain/entities/user_profile.dart';
import 'package:s_c/features/user_profile/domain/repositories/user_profile_repository.dart';

class SetUserProfileParams extends DefaultParams {
  final String userId;

  final UserProfileModel userProfile;
  const SetUserProfileParams({
    required this.userId,
    required this.userProfile,
  });
}

class SetUserProfile extends UseCase<UserProfile, SetUserProfileParams> {
  final UserProfileRepository repositoty;
  SetUserProfile({
    required this.repositoty,
  });
  @override
  Future<Either<Failure, UserProfile>?> call(
      SetUserProfileParams params) async {
    return repositoty.setUserProfile(params: params);
  }
}
