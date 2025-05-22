// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/features/register/domain/usecases/create_user_tasks_category.dart';
import 'package:s_c/features/register/domain/usecases/create_user_with_email_and_password.dart';

import '../../../../app/domain/entities/sc_user.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.createUserWithEmailAndPassword,
    required this.createUserTasksCategory,
  }) : super(const RegisterInitial(isHidePw: true));

  final CreateUserWithEmailAndPassword createUserWithEmailAndPassword;
  final CreateUserTasksCategory createUserTasksCategory;
  void toggleHidePassword() {
    emit(state.copyWith(isHidePw: !state.isHidePw));
  }

  void doTyping(String? input) {
    emit(RegisterInitial(isHidePw: state.isHidePw));
  }

  Future<void> doCreateUserWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    if (!EasyLoading.isShow) {
      EasyLoading.show(
        maskType: EasyLoadingMaskType.black,
      );
    }
    final Either<Failure, SCUser>? failureOrRegisterResult =
        await createUserWithEmailAndPassword(
            SCUser(username: username, password: password));

    failureOrRegisterResult?.fold((failure) {
      if (failure is ServerFailure) {
        EasyLoading.dismiss();
        emit(
          RegisterFailed(
            isHidePw: state.isHidePw,
            errorCode: failure.errorCode,
          ),
        );
      }
    }, (loggedUser) async {
      final failureOrResult = await createUserTasksCategory(
          CreateUserTasksCategoryParram(uid: loggedUser.uid ?? ""));
      failureOrResult?.fold((failure) {
        EasyLoading.dismiss();
        emit(
          RegisterFailed(isHidePw: state.isHidePw, errorCode: ""),
        );
      }, (r) {
        EasyLoading.dismiss();
        emit(
          RegisterSuccess(
            isHidePw: state.isHidePw,
            loggedUser: loggedUser,
          ),
        );
      });
    });
  }
}
