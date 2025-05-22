// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/core/enum/app_constants.dart';
import 'package:s_c/core/usecases/usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:s_c/app/data/datasources/app_local_data_source.dart';

import 'app_local_data_source_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(
      as: #MockSharedPreferencesForTest,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late AppLocalDataSourceImpl localDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = AppLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  const String username = "admin@self-control.com";
  const String password = "123456";
  const String uid = "uid";

  group("cachedAccount", () {
    test("should return true when cached success", () async {
      when(mockSharedPreferences.setString(CACHED_USER, any))
          .thenAnswer((_) async => Future.value(true));

      final result = await localDataSourceImpl.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      );

      expect(result, true);
    });
    test("should return false when cached failure", () async {
      when(mockSharedPreferences.setString(CACHED_USER, any))
          .thenAnswer((_) async => Future.value(false));

      final result = await localDataSourceImpl.cachedAccount(
        username: username,
        password: password,
        uid: uid,
      );

      expect(result, false);
    });
  });

  group("clear cachedAccount", () {
    test("should return true when clear cached success", () async {
      when(mockSharedPreferences.remove(CACHED_USER))
          .thenAnswer((_) async => Future.value(true));

      final result =
          await localDataSourceImpl.clearCachedAccount(noParams: NoParams());

      expect(result, true);
    });
    test("should return false when clear cached failure", () async {
      when(mockSharedPreferences.remove(CACHED_USER))
          .thenAnswer((_) async => Future.value(false));

      final result =
          await localDataSourceImpl.clearCachedAccount(noParams: NoParams());

      expect(result, false);
    });
  });
}
