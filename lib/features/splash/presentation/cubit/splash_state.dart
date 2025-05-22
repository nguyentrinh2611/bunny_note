// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashFirstLaunch extends SplashState {}

class SplashRemembered extends SplashState {
  final String username;
  final String password;
  const SplashRemembered({
    required this.username,
    required this.password,
  });
}

class SplashUnremembered extends SplashState {}
