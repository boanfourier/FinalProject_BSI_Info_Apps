import 'package:bsi_info_apps/domain/entities/user.dart';
import 'package:bsi_info_apps/domain/use_case/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User user = User(username: '', token: '');
  bool isLogin = false;
  SharedPreferences? prefs = null;

  UserProvider() {
    init();
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    isLogin = prefs?.getBool('isLogin') ?? false;
    print('isLogin: $isLogin');
  }

  Future<void> login(String username, String password) async {
    prefs = await SharedPreferences.getInstance();

    user = User(username: username, token: '');
    user.password = password;
    user = await Login().execute(user);

    if (user.token != null) {
      print(user.token);
      await prefs?.setString('username', username);
      await prefs?.setString('token', user.token);
      await prefs?.setBool('isLogin', true);
      print('TOKEN: ${prefs?.getString('token') ?? '-'}');
      isLogin = true;
    }
    notifyListeners();
  }
}
