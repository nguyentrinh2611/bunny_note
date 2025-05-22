part of 'change_pw_cubit.dart';

class ChangePwState extends Equatable {
  final bool isHideCurrentPw;
  final bool isHideNewPw;
  final bool isHideConfirmNewPw;
  const ChangePwState({
    required this.isHideCurrentPw,
    required this.isHideNewPw,
    required this.isHideConfirmNewPw,
  });

  @override
  List<Object?> get props => [isHideNewPw, isHideConfirmNewPw, isHideCurrentPw];

  ChangePwState copyWith({
    bool? isHideCurrentPw,
    bool? isHideNewPw,
    bool? isHideConfirmNewPw,
  }) {
    return ChangePwState(
      isHideCurrentPw: isHideCurrentPw ?? this.isHideCurrentPw,
      isHideNewPw: isHideNewPw ?? this.isHideNewPw,
      isHideConfirmNewPw: isHideConfirmNewPw ?? this.isHideConfirmNewPw,
    );
  }
}

class ChangePwInital extends ChangePwState {
  const ChangePwInital({
    required super.isHideCurrentPw,
    required super.isHideNewPw,
    required super.isHideConfirmNewPw,
  });

  @override
  List<Object?> get props => [
        [isHideNewPw, isHideConfirmNewPw, isHideCurrentPw]
      ];
}

class ChangePwLoading extends ChangePwState {
  const ChangePwLoading({
    required super.isHideCurrentPw,
    required super.isHideNewPw,
    required super.isHideConfirmNewPw,
  });
  @override
  List<Object?> get props => [
        [isHideNewPw, isHideConfirmNewPw, isHideCurrentPw]
      ];
}

class ChangePwSuccess extends ChangePwState {
  final SCUser loggedUser;
  const ChangePwSuccess({
    required super.isHideCurrentPw,
    required super.isHideNewPw,
    required super.isHideConfirmNewPw,
    required this.loggedUser,
  });

  @override
  List<Object?> get props =>
      [isHideNewPw, isHideConfirmNewPw, isHideCurrentPw, loggedUser];
}

class ChangePwFailed extends ChangePwState {
  final Failure failure;
  const ChangePwFailed({
    required this.failure,
    required super.isHideCurrentPw,
    required super.isHideNewPw,
    required super.isHideConfirmNewPw,
  });

  @override
  List<Object?> get props =>
      [isHideNewPw, isHideConfirmNewPw, isHideCurrentPw, failure];
}
