import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/change_pw.dart';

part 'change_pw_state.dart';

class ChangePwCubit extends Cubit<ChangePwState> {
  final ChangePw changePw;

  ChangePwCubit({
    required this.changePw,
  }) : super(const ChangePwInital(
            isHideNewPw: true,
            isHideCurrentPw: true,
            isHideConfirmNewPw: true));

  void toggleHideCurrentPassword() {
    emit(state.copyWith(isHideCurrentPw: !state.isHideCurrentPw));
  }

  void toggleHideNewPassword() {
    emit(state.copyWith(isHideNewPw: !state.isHideNewPw));
  }

  void toggleHideConfirmNewPassword() {
    emit(state.copyWith(isHideConfirmNewPw: !state.isHideConfirmNewPw));
  }

  void doTyping(String? input) {}

  Future<void> doUpdatePassword({
    required String newPassword,
    required SCUser user,
  }) async {
    emit(ChangePwLoading(
      isHideCurrentPw: state.isHideCurrentPw,
      isHideNewPw: state.isHideNewPw,
      isHideConfirmNewPw: state.isHideConfirmNewPw,
    ));
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );

    final failureOfResult = await changePw
        .call(ChangePwParams(user: user.copyWith(password: newPassword)));

    failureOfResult?.fold((failure) {
      EasyLoading.dismiss();

      emit(ChangePwFailed(
        failure: failure,
        isHideCurrentPw: state.isHideCurrentPw,
        isHideNewPw: state.isHideNewPw,
        isHideConfirmNewPw: state.isHideConfirmNewPw,
      ));
    }, (result) {
      EasyLoading.dismiss();
      emit(
        ChangePwSuccess(
          isHideCurrentPw: state.isHideCurrentPw,
          isHideNewPw: state.isHideNewPw,
          isHideConfirmNewPw: state.isHideConfirmNewPw,
          loggedUser: result,
        ),
      );
    });
  }
}
