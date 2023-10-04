part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.hasLogin() = HasLogin;

  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = UserLogin;

  const factory AuthEvent.loginYielded(ResourceState<void> state) =
      UserLoginYielded;

  const factory AuthEvent.logout() = UserLogout;

  const factory AuthEvent.logoutYielded(ResourceState<void> state) =
      UserLogoutYielded;

  const factory AuthEvent.getProfile() = GetProfile;

  const factory AuthEvent.getProfileYielded(ResourceState<void> state) =
      GetProfileYielded;
}
