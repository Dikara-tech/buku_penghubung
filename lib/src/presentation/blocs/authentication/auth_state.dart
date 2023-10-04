part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required ResourceState<void> getProfileState,
    required ResourceState<void> loginState,
    required ResourceState<void> logoutState,
    required bool isLoggedIn,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(
        getProfileState: ResourceState.initial(),
        loginState: ResourceState.initial(),
        logoutState: ResourceState.initial(),
        isLoggedIn: false,
      );
}
