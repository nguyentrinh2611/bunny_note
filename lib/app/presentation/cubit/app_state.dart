// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

class AppState extends Equatable {
  final AppTheme? appTheme;
  final Locale? appLanguage;
  final AppAuthState authState;

  const AppState({
    this.appTheme,
    this.appLanguage,
    required this.authState,
  });

  @override
  List<Object?> get props => [appTheme, appLanguage, authState];

  AppState copyWith({
    AppTheme? appTheme,
    Locale? appLanguage,
    AppAuthState? authState,
  }) {
    return AppState(
      appTheme: appTheme ?? this.appTheme,
      appLanguage: appLanguage ?? this.appLanguage,
      authState: authState ?? this.authState,
    );
  }
}

class AppAuthState {
  final bool? isLoged;
  final SCUser? user;
  AppAuthState({
    this.isLoged,
    this.user,
  });

  @override
  String toString() => 'AppAuthState(isLoged: $isLoged, user: $user)';
}
