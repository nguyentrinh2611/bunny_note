import 'package:flutter_test/flutter_test.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/features/splash/data/models/sc_user_model.dart';
import 'dart:convert';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const admin = SCUserModel(username: "admin", password: "admin");

  test('should be a subclass of NumberTrivia entity', () async {
    //assert
    expect(admin, isA<SCUser>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));
      //act
      final result = SCUser.fromMap(jsonMap);
      //assert
      expect(result, equals(admin));
    });
    test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('user.json'));

      //act
      final result = SCUser.fromMap(jsonMap);
      //assert
      expect(result, equals(admin));
    });
  });

  group('toJson', () {
    test('should return ', () async {
      //act
      final result = admin.toMap();
      //assert
      final expectedMap = {
        "username": "admin",
        "password": "admin",
        "uid": null,
        "dbUid": null
      };
      expect(result, equals(expectedMap));
    });
  });
}
