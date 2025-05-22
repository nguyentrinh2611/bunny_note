// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final bool isHidePw;
  const RegisterState({
    required this.isHidePw,
  });
  @override
  List<Object?> get props => [isHidePw];

  RegisterState copyWith({
    bool? isHidePw,
    bool? isRememberAccount,
  }) {
    return RegisterState(
      isHidePw: isHidePw ?? this.isHidePw,
    );
  }
}

class RegisterInitial extends RegisterState {
  const RegisterInitial({
    required super.isHidePw,
  });

  @override
  List<Object?> get props => [
        isHidePw,
      ];
}

class RegisterSuccess extends RegisterState {
  final SCUser loggedUser;
  const RegisterSuccess({
    required super.isHidePw,
    required this.loggedUser,
  });

  @override
  List<Object?> get props => [isHidePw, loggedUser];
}

class RegisterFailed extends RegisterState {
  final String? errorCode;
  const RegisterFailed({
    this.errorCode,
    required super.isHidePw,
  });

  @override
  List<Object?> get props => [isHidePw, errorCode];
}
