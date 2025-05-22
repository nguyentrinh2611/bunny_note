// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/features/user_profile/domain/entities/user_profile.dart';

import 'package:s_c/features/user_profile/domain/repositories/user_profile_repository.dart';
import 'package:s_c/features/user_profile/domain/usecases/get_user_profile.dart';

import 'get_user_profile_test.mocks.dart';

@GenerateMocks([UserProfileRepository])
void main() {
  late MockUserProfileRepository mockUserProfileRepository;
  late GetUserProfile usecase;

  setUp(() {
    mockUserProfileRepository = MockUserProfileRepository();
    usecase = GetUserProfile(repositoty: mockUserProfileRepository);
  });

  const res = UserProfile(
      name: "name",
      address: "address",
      phone: "phone",
      gender: "gender",
      avatarUrl: "avatarUrl");

  test("> Should is connected to repository or not", () async {
    when(mockUserProfileRepository.getUserProfile(
            params: const GetUserProfileParams(userId: "userId")))
        .thenAnswer((realInvocation) async => const Right(res));
    final result =
        await usecase.call(const GetUserProfileParams(userId: "userId"));
    expect(result, const Right(res));
  });
}
