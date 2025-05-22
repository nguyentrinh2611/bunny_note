// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/features/login/domain/usecases/login_with_username_and_pw.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginWithUsernameAndPw,
  }) : super(const LoginInitial(isHidePw: true, isRememberAccount: true));
  LoginState get initial =>
      const LoginInitial(isHidePw: true, isRememberAccount: true);

  final LoginWithUsernameAndPw loginWithUsernameAndPw;

  void toggleHidePassword() {
    emit(state.copyWith(isHidePw: !state.isHidePw));
  }

  void toggleRememberAccount() {
    emit(state.copyWith(isRememberAccount: !state.isRememberAccount));
  }

  void doTyping(String? input) {
    emit(LoginInitial(
        isHidePw: state.isHidePw, isRememberAccount: state.isRememberAccount));
  }

  Future<void> doLoginWithUsernameAndPw({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      emit(
        LoginFailed(
          isHidePw: state.isHidePw,
          isRememberAccount: state.isRememberAccount,
          errorCode: "Invalid username / password",
        ),
      );
      return;
    }
    if (!EasyLoading.isShow) {
      EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
      );
    }
    final Either<Failure, SCUser>? failureOrLoginResult =
        await loginWithUsernameAndPw(
            SCUser(username: username, password: password));

    failureOrLoginResult!.fold((failure) {
      if (failure is ServerFailure) {
        EasyLoading.dismiss();
        emit(
          LoginFailed(
            isHidePw: state.isHidePw,
            isRememberAccount: state.isRememberAccount,
            errorCode: failure.errorCode,
          ),
        );
      }
    }, (loggedUser) async {
      EasyLoading.dismiss();
      emit(
        LoginSuccess(
          isHidePw: state.isHidePw,
          isRememberAccount: state.isRememberAccount,
          loggedUser: loggedUser,
        ),
      );
    });
  }
}
