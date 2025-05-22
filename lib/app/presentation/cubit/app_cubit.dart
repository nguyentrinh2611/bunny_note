import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enum/app_languages.dart';
import '../../../core/enum/app_theme.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/sc_user.dart';
import '../../domain/usecases/clear_remembered_account.dart';
import '../../domain/usecases/remember_account.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final RememberAccount rememberAccount;
  final ClearRememberedAccount clearRememberedAccount;
  AppCubit({
    required this.rememberAccount,
    required this.clearRememberedAccount,
  }) : super(
          AppState(
            appTheme: AppTheme.dark,
            appLanguage: appSupportedLanguages.first,
            authState: AppAuthState(isLoged: false),
          ),
        );
  void toggleLanguage(Locale newLanguage) {
    emit(state.copyWith(
        appLanguage: appSupportedLanguages.firstWhere(
            (element) => element.languageCode == newLanguage.languageCode)));
  }

  void login({
    required String username,
    required String password,
    required String uid,
    bool isRememmber = false,
  }) async {
    emit(
      state.copyWith(
        authState: AppAuthState(
          isLoged: true,
          user: SCUser(username: username, password: password, uid: uid),
        ),
      ),
    );
    if (isRememmber) {
      await doRememberAccount(username: username, password: password);
    } else {
      await doClearRememberedAccount();
    }
  }

  void logout() async {
    await doClearRememberedAccount();
    emit(state.copyWith(authState: AppAuthState(isLoged: false)));
  }

  Future<bool> doRememberAccount({
    required String username,
    required String password,
  }) async {
    final Either<Failure, bool>? failureOrResult =
        await rememberAccount(SCUser(username: username, password: password));
    return failureOrResult != null
        ? failureOrResult.fold((failure) {
            //todo: do something

            return false;
          }, (result) {
            return result;
          })
        : false;
  }

  Future<bool> doClearRememberedAccount() async {
    final Either<Failure, bool>? failureOrResult =
        await clearRememberedAccount(NoParams());
    return failureOrResult != null
        ? failureOrResult.fold((failure) {
            //todo: do something

            return false;
          }, (result) {
            return result;
          })
        : false;
  }
}
