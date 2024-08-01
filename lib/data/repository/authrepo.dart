import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedRepo {
  Future<Map<String, String>> getCredentialsFromSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? fullName = prefs.getString('fullName');
    String? phone = prefs.getString('phone');
    String? address = prefs.getString('address');
    String? password = prefs.getString('password');
    return {
      'fullName': fullName ?? '',
      'email': email ?? '',
      'phone': phone ?? '',
      'address': address ?? '',
      'password': password ?? ''
    };
  }
}
