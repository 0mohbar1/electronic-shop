import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedRepo {
  Future<Map<String, String>> getCredentialsFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    return {'email': email ?? '', 'password': password ?? ''};
  }
}