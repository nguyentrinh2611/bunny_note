// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:s_c/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/features/change_pw/data/datasources/change_pw_local_data_source.dart';

import 'change_pw_local_data_source_test.mocks.dart';

@GenerateMocks([
  SharedPreferences
], customMocks: [
  MockSpec<SharedPreferences>(
      as: #MockSharedPreferencesForTest,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late ChangePwLocalDataSourceImpl changePwLocalDataSourceImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    changePwLocalDataSourceImpl =
        ChangePwLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  const user = SCUser(username: "a", password: "123456", uid: "uid");
  test('>Cached new user failurre', () async {
    //arrange
    when(mockSharedPreferences.getString(any)).thenReturn(null);
    //act
    final call = changePwLocalDataSourceImpl.getCachedUser;
    //assert
    expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
  });

  // when(mockSharedPreferences.getString(CACHED_USER))
  //     .thenAnswer((realInvocation) => json.encode(user.toMap()));
}
