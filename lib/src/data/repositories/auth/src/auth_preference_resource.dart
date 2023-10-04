import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

@LazySingleton()
class AuthPreferenceLocalResource {
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<bool> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', token);
  }

  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_token');
  }

  Future<bool> setUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('user_token', token);
  }

  Future<String> getCustomerId() async {
    final prefs = await SharedPreferences.getInstance();
    var res = prefs.getString('customer_id');
    if (res == null) {
      /// generate random uuid for identifier purpose
      const uuid = Uuid();
      res = uuid.v4();

      await setCustomerId(res);
    }

    return res;
  }

  Future<bool> setCustomerId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('customer_id', id);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
