import 'dart:convert';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/enum/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class ChangePwLocalDataSource {
  Future<void> saveChangedPw({required SCUser user});

  Future<SCUser>? getCachedUser();
}

class ChangePwLocalDataSourceImpl implements ChangePwLocalDataSource {
  final SharedPreferences sharedPreferences;
  ChangePwLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<void> saveChangedPw({
    required SCUser user,
  }) {
    return sharedPreferences.setString(CACHED_USER, json.encode(user.toMap()));
  }

  @override
  Future<SCUser>? getCachedUser() async {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(SCUser.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
