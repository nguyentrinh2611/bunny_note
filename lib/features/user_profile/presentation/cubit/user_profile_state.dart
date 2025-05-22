// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileHasnotExistState extends UserProfileState {}

class UserProfileGetDone extends UserProfileState {
  final UserProfile userProfile;
  const UserProfileGetDone({
    required this.userProfile,
  });
  @override
  List<Object> get props => [userProfile];

  UserProfileGetDone copyWith({
    UserProfile? userProfile,
  }) {
    return UserProfileGetDone(
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

class UserProfileSetDone extends UserProfileState {
  final UserProfile userProfile;
  const UserProfileSetDone({
    required this.userProfile,
  });
  @override
  List<Object> get props => [userProfile];

  UserProfileSetDone copyWith({
    UserProfile? userProfile,
  }) {
    return UserProfileSetDone(
      userProfile: userProfile ?? this.userProfile,
    );
  }
}
