// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_first_launch.dart';
import '../../domain/usecases/check_remembered_login.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.checkFirstLaunch,
    required this.checkRememberedLogin,
  }) : super(SplashInitial());

  final CheckFirstLaunch checkFirstLaunch;
  final CheckRememberedLogin checkRememberedLogin;
  SplashState get initialState => SplashInitial();

  void checkIsFirstLaunch() async {
    final result = await checkFirstLaunch(NoParams());
    result!.fold((l) {
      return;
    }, (r) {
      if (r) {
        checkIsRememberedLogin();
        // emit(SplashFirstLaunch());
      } else {
        checkIsRememberedLogin();
      }
    });
    return;
  }

  void checkIsRememberedLogin() async {
    final result = await checkRememberedLogin(NoParams());
    result!.fold((l) {
      emit(SplashUnremembered());
    }, (r) {
      emit(SplashRemembered(username: r.username, password: r.password));
    });
  }
}
