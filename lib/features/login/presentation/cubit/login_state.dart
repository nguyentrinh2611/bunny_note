// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isHidePw;
  final bool isRememberAccount;
  const LoginState({
    required this.isHidePw,
    required this.isRememberAccount,
  });
  @override
  List<Object?> get props => [isHidePw, isRememberAccount];

  LoginState copyWith({
    bool? isHidePw,
    bool? isRememberAccount,
  }) {
    return LoginState(
      isHidePw: isHidePw ?? this.isHidePw,
      isRememberAccount: isRememberAccount ?? this.isRememberAccount,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial(
      {required super.isHidePw, required super.isRememberAccount});

  @override
  List<Object?> get props => [isHidePw, isRememberAccount];
}

class LoginSuccess extends LoginState {
  final SCUser loggedUser;
  const LoginSuccess({
    required super.isHidePw,
    required super.isRememberAccount,
    required this.loggedUser,
  });

  @override
  List<Object?> get props => [isHidePw, isRememberAccount, loggedUser];
}

class LoginFailed extends LoginState {
  final String? errorCode;
  const LoginFailed(
      {required super.isHidePw,
      required super.isRememberAccount,
      this.errorCode});

  @override
  List<Object?> get props => [isHidePw, isRememberAccount, errorCode];
}
