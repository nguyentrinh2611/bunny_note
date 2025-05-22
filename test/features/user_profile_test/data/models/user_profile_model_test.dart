import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:s_c/features/user_profile/data/models/user_profile_model.dart';
import 'package:s_c/features/user_profile/domain/entities/user_profile.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  // const tNumberTriviaModel = NumberTriviaModel(number: 1, text: "1 Test text");
  const tUserProfileModel = UserProfileModel(
      name: "name",
      address: "address",
      phone: "phone",
      gender: "gender",
      avatarUrl: "avatarUrl");
  test('should be a subclass of UserProfile entity', () async {
    //assert
    expect(tUserProfileModel, isA<UserProfile>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('user_profile.json'));
      //act
      final result = UserProfileModel.fromMap(jsonMap);
      //assert
      expect(result, equals(tUserProfileModel));
    });
  });

  group('toJson', () {
    test('should return ', () async {
      //act
      final result = tUserProfileModel.toMap();
      //assert
      final expectedMap = {
        "name": "name",
        "address": "address",
        "phone": "phone",
        "gender": "gender",
        "avatarUrl": "avatarUrl"
      };
      expect(result, equals(expectedMap));
    });
  });
}
