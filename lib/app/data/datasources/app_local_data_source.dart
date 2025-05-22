// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:s_c/core/enum/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/usecases/usecase.dart';
import '../../domain/entities/sc_user.dart';

abstract class AppLocalDataSource {
  Future<bool> cachedAccount({
    required String username,
    required String password,
    required String uid,
  });

  Future<bool> clearCachedAccount({required NoParams noParams});
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  final SharedPreferences sharedPreferences;
  AppLocalDataSourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<bool> cachedAccount({
    required String username,
    required String password,
    required String uid,
  }) async {
    final bool result = await sharedPreferences.setString(
        CACHED_USER,
        json.encode(
            SCUser(username: username, password: password, uid: uid).toMap()));
    return result;
  }

  @override
  Future<bool> clearCachedAccount({
    required NoParams noParams,
  }) async {
    final bool result = await sharedPreferences.remove(
      CACHED_USER,
    );
    return result;
  }
}
