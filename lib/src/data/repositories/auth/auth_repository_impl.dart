import 'dart:async';

import 'package:buku_penghubung/src/data/repositories/auth/src/auth_api_resource.dart';
import 'package:buku_penghubung/src/data/repositories/auth/src/auth_preference_resource.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthenticationRepository {
  final AuthApiSource _authApiSource;
  final AuthPreferenceLocalResource _authPreferenceLocalResource;

  AuthenticationRepository(
    this._authApiSource,
    this._authPreferenceLocalResource,
  );

  Future<bool> userIsLoggedIn() async {
    // set user token for fetching purpose
    return await _authPreferenceLocalResource.getUserToken() != null;
  }
}
