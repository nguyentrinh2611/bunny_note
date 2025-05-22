// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/features/user_profile/data/models/user_profile_model.dart';

import 'package:s_c/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:s_c/features/user_profile/domain/usecases/set_user_profile.dart';

import 'get_user_profile_test.mocks.dart';

@GenerateMocks([UserProfileRepository])
void main() {
  late MockUserProfileRepository mockUserProfileRepository;
  late SetUserProfile usecase;

  setUp(() {
    mockUserProfileRepository = MockUserProfileRepository();
    usecase = SetUserProfile(repositoty: mockUserProfileRepository);
  });

  const res = UserProfileModel(
    name: "name",
    address: "address",
    phone: "phone",
    gender: "gender",
    avatarUrl: "avatarUrl",
  );

  test("> Should is connected to repository or not", () async {
    when(mockUserProfileRepository.setUserProfile(
            params:
                const SetUserProfileParams(userId: "userId", userProfile: res)))
        .thenAnswer((realInvocation) async => const Right(res));
    final result = await usecase
        .call(const SetUserProfileParams(userId: "userId", userProfile: res));
    expect(result, const Right(res));
  });
}
