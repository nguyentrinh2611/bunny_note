// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'dart:convert';

import 'package:s_c/core/enum/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/exceptions.dart';

abstract class SplashLocalDataSource {
  Future<SCUser>? getRememberedAccount();
  Future<bool>? getCachedFirstLaunchFlag();
}

class SplashLocalDataSourceImpl extends SplashLocalDataSource {
  final SharedPreferences sharedPreferences;
  SplashLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<bool>? getCachedFirstLaunchFlag() {
    final jsonString = sharedPreferences.getString(CACHED_FIRST_LAUNCH_FLAG);
    if (jsonString != null) {
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Future<SCUser>? getRememberedAccount() {
    final jsonString = sharedPreferences.getString(CACHED_USER);
    if (jsonString != null) {
      return Future.value(SCUser.fromMap(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
