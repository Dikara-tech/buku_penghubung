import 'dart:async';

import 'package:buku_penghubung/src/data/repositories/repositories.dart';
import 'package:buku_penghubung/src/data/states/resource/resource_state.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;

  StreamSubscription<ResourceState<void>>? _loginSubscription;
  StreamSubscription<ResourceState<void>>? _logoutSubscription;
  StreamSubscription<ResourceState<void>>? _getProfileSubscription;

  AuthBloc(
    this._authenticationRepository,
  ) : super(AuthState.initial()) {
    on<HasLogin>(_handleUserHasLogin);
    on<GetProfile>(_handleGetProfile);
    on<GetProfileYielded>(_handleGetProfileYielded);

    // Login
    on<UserLogin>(_handleLogin);
    on<UserLoginYielded>(_handleLoginYielded);
    on<UserLogout>(_handleLogout);
    on<UserLogoutYielded>(_handleLogoutYielded);

    add(const AuthEvent.hasLogin());
  }

  @override
  Future<void> close() async {
    await _loginSubscription?.cancel();
    await _logoutSubscription?.cancel();
    await _getProfileSubscription?.cancel();
    await super.close();
  }

  Future<void> _handleUserHasLogin(
    HasLogin event,
    Emitter<AuthState> emit,
  ) async {
    Fimber.i('Check User has login...');
    final isLoggedIn = await _authenticationRepository.userIsLoggedIn();
    emit(state.copyWith(
      isLoggedIn: isLoggedIn,
    ));
  }

  void _handleGetProfile(
    GetProfile event,
    Emitter<AuthState> emit,
  ) {}

  void _handleGetProfileYielded(
    GetProfileYielded event,
    Emitter<AuthState> emit,
  ) {
    event.state.map(
      initial: (_) {},
      loading: (result) {
        Fimber.i('Getting user profile...');
        emit(state.copyWith(
          getProfileState: result,
        ));
      },
      success: (result) {
        Fimber.i('Successfully got user profile.');
        emit(state.copyWith(
          getProfileState: result,
        ));
      },
      error: (result) {
        Fimber.e(
          'Failed to get user profile: Code: ${result.code}\n'
          'Message: ${result.message}\n'
          'Stacktrace: ${result.stacktrace}',
        );
        emit(state.copyWith(
          getProfileState: result,
        ));
      },
    );
  }

  Future<void> _handleLogin(
    UserLogin event,
    Emitter<AuthState> emit,
  ) async {
    await _loginSubscription?.cancel();

    // _loginSubscription = _loginInteractor(
    //   email: event.email,
    //   password: event.password,
    //   method: event.method,
    // ).listen((result) {
    //   add(AuthEvent.loginYielded(result));
    // });
  }

  void _handleLoginYielded(
    UserLoginYielded event,
    Emitter<AuthState> emit,
  ) {
    event.state.map(
      initial: (_) {},
      loading: (result) {
        Fimber.i('Logging in...');
        emit(state.copyWith(
          loginState: result,
        ));
      },
      success: (result) {
        Fimber.i('Successfully logged the user.');
        emit(state.copyWith(
          loginState: result,
        ));

        add(const AuthEvent.hasLogin());

        emit(state.copyWith(
          loginState: const ResourceState.initial(),
        ));
      },
      error: (result) {
        Fimber.e(
          'Failed to log user: Code: ${result.code}\n'
          'Message: ${result.message}\n'
          'Stacktrace: ${result.stacktrace}',
        );
        emit(state.copyWith(
          loginState: result,
        ));

        emit(state.copyWith(
          loginState: const ResourceState.initial(),
        ));
      },
    );
  }

  Future<void> _handleLogout(
    UserLogout event,
    Emitter<AuthState> emit,
  ) async {
    await _logoutSubscription?.cancel();

    // _logoutSubscription = _logoutInteractor().listen((result) {
    //   add(AuthEvent.logoutYielded(result));
    // });
  }

  void _handleLogoutYielded(
    UserLogoutYielded event,
    Emitter<AuthState> emit,
  ) {
    event.state.map(
      initial: (_) {},
      loading: (result) {
        Fimber.i('Logging out...');
        emit(state.copyWith(
          logoutState: result,
        ));
      },
      success: (result) {
        Fimber.i('Successfully logged the user.');
        emit(state.copyWith(
          logoutState: result,
        ));

        add(const AuthEvent.hasLogin());

        emit(state.copyWith(
          logoutState: const ResourceState.initial(),
        ));
      },
      error: (result) {
        Fimber.e(
          'Failed to log user: Code: ${result.code}\n'
          'Message: ${result.message}\n'
          'Stacktrace: ${result.stacktrace}',
        );
        emit(state.copyWith(
          logoutState: result,
        ));

        emit(state.copyWith(
          logoutState: const ResourceState.initial(),
        ));
      },
    );
  }
}
